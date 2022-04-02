import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:dotenv/dotenv.dart' show env;

class VaultController {
  FutureOr info(HttpRequest req, HttpResponse res) async {
    final dir = Directory('./');
    final List<String> files =
        await dir.list().map((entity) => entity.path).toList();

    return {
      'files': files.join(' : '),
      'cloud_name': env['CLOUDINARY_CLOUD_NAME']
    };
  }

  FutureOr index(HttpRequest req, HttpResponse res) async {
    final password = req.uri.queryParameters['password'];
    if (!_isValidKeyRequest(password))
      throw AlfredException(401, {'message': 'authentication failed'});

    final tokens = {
      'key': env['API_KEY'],
      'token': env['API_TOKEN'],
    };

    return tokens;
  }

  bool _isValidKeyRequest(String? password) {
    if (password?.isEmpty ?? true) return false;

    final expected = env['PASSWORD'];
    return password == expected;
  }
}
