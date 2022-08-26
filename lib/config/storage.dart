import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// Create storage
class Storage {
  final storage = FlutterSecureStorage();

// Read value
  Future<String?> readSingleValue(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  void readAllValues() async {
    Map<String, String> allValues = await storage.readAll();
  }

  void deleteSingleValue(String key) async {
    await storage.delete(key: key);
  }

  void deleteAllValues() async {
    await storage.deleteAll();
  }

  Future<void> saveValue(String key, String value) async {
    await storage.write(key: key, value: value);
    print('saving');
  }
}
