import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String rJTW = "rJWT";
final String userNameKey = "userName";
final String email = "email";

class UserStore {
  final FlutterSecureStorage storage;
  String? _token;
  String? _userName;
  String? _email;

  UserStore({required this.storage});

  void setToken(
    String newToken,
  ) {
    this._token = newToken;
  }

  String? getToken() {
    return this._token;
  }

  void setUseName(
    String userName,
  ) {
    this._userName = userName;
  }

  void setEmail(
    String email,
  ) {
    this._email = email;
  }

  Future<String?> getRefreshToken() async {
    try {
      return await storage.read(key: rJTW);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getUserName() async {
    try {
      _userName ??= await storage.read(key: userNameKey);
      return _userName;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getEmail() async {
    try {
      _email ??= await storage.read(key: email);
      return _email;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> save({
    required String userName,
    required String refreshToken,
    required String email,
  }) async {
    try {
      await storage.write(key: rJTW, value: refreshToken);
      await storage.write(key: userNameKey, value: _userName);
      await storage.write(key: email, value: _email);
      this._userName = userName;
      this._email = email;
    } catch (e) {
      print(e);
    }
  }
}
