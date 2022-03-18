import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:token_keeper/vault_controller.dart';
import 'package:token_keeper/frontend_controller.dart';
import 'package:dotenv/dotenv.dart' show load;

void main() async {
  load();

  final app = Alfred();

  app.get('/', VaultController().index);

  app.get('/uploader/*', FrontendController().assets);
  app.get('/uploader/*', FrontendController().index);
  app.post('/uploader/upload', FrontendController().upload);

  final envPort = Platform.environment['PORT'];

  final server = await app.listen(envPort != null ? int.parse(envPort) : 8080);

  print("Listening on ${server.port}");
}
