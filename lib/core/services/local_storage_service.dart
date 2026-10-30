class LocalStorageService {
  static final Map<String, dynamic> _memoryStorage = {};

  static Future<void> saveString(String key, String value) async {
    _memoryStorage[key] = value;
  }

  static String? getString(String key) {
    return _memoryStorage[key] as String?;
  }

  static Future<void> clear() async {
    _memoryStorage.clear();
  }
}
