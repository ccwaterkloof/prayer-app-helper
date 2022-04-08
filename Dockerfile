FROM dart:2.16.1 AS build

# Get the dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy dart source code and compile it.
COPY . .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from build stage assets.
FROM busybox as runtime
# Copy required system libraries and configuration files.
COPY --from=build /runtime/ /
# Copy the executable
COPY --from=build /app/bin/server /app/bin/
# Copy the web assets
COPY ./public /public
RUN ls -laR /public
# COPY .env .env

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]