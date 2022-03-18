import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:dotenv/dotenv.dart' show env;

class VaultController {
  // VaultController._() {
  //   load();
  // }

  // static final VaultController _instance = VaultController._();

  // factory VaultController() {
  //   return _instance;
  // }

  FutureOr index(HttpRequest req, HttpResponse res) async {
    final password = req.uri.queryParameters['password'];
    if (!_isValidKeyRequest(password))
      throw AlfredException(401, {'message': 'authentication failed'});

    final tokens = {
      'kee': env['API_KEY'],
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
