import 'package:alfred/alfred.dart';
import 'package:token_keeper/vault_controller.dart';
import 'package:token_keeper/upload_controller.dart';
import 'package:dotenv/dotenv.dart' show load, env;

void main() async {
  load();

  final app = Alfred();

  app.get('/', VaultController().index);

  app.get('/uploader/*', UploadController().assets);
  app.get('/uploader/*', UploadController().index);
  app.post('/uploader/upload', UploadController().upload);

  final envPort = env['PORT'];

  final server = await app.listen(envPort != null ? int.parse(envPort) : 8080);

  print("Listening on ${server.port}");
}
