FROM dart:2.16.1 AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM busybox as runtime
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/
COPY ./public /public
# COPY .env .env

# Start server.
EXPOSE 8080
# CMD ["/app/bin/server"]
CMD /app/bin/server