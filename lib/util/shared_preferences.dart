import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePreference(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> getPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<void> saveBoolPreference(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

Future<bool> getBoolPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}
