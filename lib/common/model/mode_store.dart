import 'package:shared_preferences/shared_preferences.dart';

final String modeKey = "modeKey";

class CurrentMode {
  bool? _isDarkMode;
  final SharedPreferences storage;

  CurrentMode({
    required this.storage,
  });

  Future<bool?> getCurrentMode() async {
    try {
      return _isDarkMode ?? storage.getBool(modeKey);
    } catch (e) {
      return null;
    }
  }

  Future<void> save(bool isDark) async {
    storage.setBool(modeKey, isDark);
    this._isDarkMode = isDark;
  }
}
