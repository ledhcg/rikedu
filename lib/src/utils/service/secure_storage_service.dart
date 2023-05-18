import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final _storage = const FlutterSecureStorage();

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
