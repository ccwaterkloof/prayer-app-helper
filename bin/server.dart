import 'package:alfred/alfred.dart';
import 'package:token_keeper/vault_controller.dart';
import 'package:token_keeper/upload_controller.dart';
import 'package:dotenv/dotenv.dart' show load, env;

void main() async {
  load();

  final app = Alfred();

  app.get('/', VaultController().index);
  app.get('/info', VaultController().info);

  app.get('/uploader/*', UploadController().assets);
  app.get('/uploader/*', UploadController().index);
  app.post('/uploader/upload', UploadController().upload);

  final envPort = env['PORT'] ?? "8080";

  final server = await app.listen(int.parse(envPort));

  print("Listening on ${server.port}");
}
