import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String rJTW = "rJWT";
final String userNameKey = "userName";

class UserStore {
  final FlutterSecureStorage storage;
  String? _token;
  String? _userName;

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

  Future<void> save({
    required String userName,
    required String refreshToken,
  }) async {
    try {
      await storage.write(key: rJTW, value: refreshToken);
      await storage.write(key: userNameKey, value: _userName);
      this._userName = userName;
    } catch (e) {
      print(e);
    }
  }
}
