import 'dart:async';
import 'preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // Private constructor
  SharedPreferenceHelper._();

  // Singleton instance
  static final SharedPreferenceHelper _instance = SharedPreferenceHelper._();

  // Factory constructor to return the same instance
  factory SharedPreferenceHelper() => _instance;

  // SharedPreferences instance
  SharedPreferences? _sharedPreference;

  // Initialize SharedPreferences
  Future<void> init() async {
    _sharedPreference ??= await SharedPreferences.getInstance();
  }

  // Getter to ensure SharedPreferences is initialized
  SharedPreferences get _prefs {
    if (_sharedPreference == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _sharedPreference!;
  }

  // General Methods: ----------------------------------------------------------
  String? get authToken {
    return _prefs.getString(Preferences.auth_token);
  }

  String? get roleId {
    return _prefs.getString(Preferences.roleId);
  }

  String? get refreshToken {
    return _prefs.getString(Preferences.refreshToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _prefs.setString(Preferences.auth_token, authToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _prefs.setString(Preferences.refreshToken, refreshToken);
  }

  Future<bool> saveRoleId(String roleId) async {
    return _prefs.setString(Preferences.roleId, roleId);
  }

  Future<bool> removeAuthToken() async {
    return _prefs.remove(Preferences.auth_token);
  }

  Future<bool> removeRefreshToken() async {
    return _prefs.remove(Preferences.refreshToken);
  }

  // Login:---------------------------------------------------------------------
  bool get isLoggedIn {
    return _prefs.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _prefs.setBool(Preferences.is_logged_in, value);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
