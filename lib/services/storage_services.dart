import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> clearAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // Add other methods for storing different data types (int, bool, etc.)
}
