import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DirectoryService{
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> storeDownloadDirectory(String path) async {
    await storage.write(key: 'download_directory', value: path);
  }

  Future<String?> getDownloadDirectory() async {
    String? downloadPath = await storage.read(key: 'download_directory');
    return downloadPath;
  }

  Future<void> deleteDownloadDirectory() async {
    await storage.delete(key: 'download_directory');
  }
}
