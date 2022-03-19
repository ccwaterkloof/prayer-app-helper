import 'dart:async';
import 'dart:io';
import 'package:alfred/alfred.dart';
import 'package:dotenv/dotenv.dart' show env;
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class UploadController {
  FutureOr index(HttpRequest req, HttpResponse res) {
    res.headers.contentType = ContentType.html;
    return File('public/index.html');
  }

  FutureOr assets(HttpRequest req, HttpResponse res) {
    return Directory('public');
  }

  FutureOr upload(HttpRequest req, HttpResponse res) async {
    final body = await req.bodyAsJsonMap;
    final expected = env['PASSWORD'];
    if (body['password'] != expected)
      throw AlfredException(401, {'message': 'authentication failed'});

    // Get the uploaded file content
    final uploadedFile = (body['memberImage'] as HttpBodyFileUpload);
    final fileBytes = (uploadedFile.content as List<int>);

    // Upload the file to Cloudinary
    final cloudinary = Cloudinary(
      env['CLOUDINARY_API_KEY'] ?? '',
      env['CLOUDINARY_API_SECRET'] ?? '',
      env['CLOUDINARY_CLOUD_NAME'] ?? '',
    );

    final response = await cloudinary.uploadFile(
      fileBytes: fileBytes,
      resourceType: CloudinaryResourceType.image,
      folder: 'members',
      optParams: {
        'transformation': 'c_limit,h_500,w_500/c_fill,h_375,w_500',
      },
    );

    final result = (response.isSuccessful)
        ? "${response.secureUrl}"
        : "failed: ${response.error}";

    return {"message": result};
  }
}
