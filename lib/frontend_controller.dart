import 'dart:async';
import 'dart:io';
import 'package:alfred/alfred.dart';

class FrontendController {
  FutureOr index(HttpRequest req, HttpResponse res) {
    res.headers.contentType = ContentType.html;
    return File('public/index.html');
  }

  FutureOr assets(HttpRequest req, HttpResponse res) {
    return Directory('public');
  }

  FutureOr upload(HttpRequest req, HttpResponse res) async {
    // throw AlfredException(400, {"message": "invalid request"});
    final body = await req.bodyAsJsonMap;

    // Get the uploaded file content
    final uploadedFile = (body['memberImage'] as HttpBodyFileUpload);
    final fileBytes = (uploadedFile.content as List<int>);
    final result = "uploaded ${fileBytes.length} bytes";
    return {"message": result};
  }
}
