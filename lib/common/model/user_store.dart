import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String rJTW = "rJWT";
final String userNameKey = "userName";
final String emailKey = "email";
final String phoneKey = "phone";

class UserStore {
  final FlutterSecureStorage storage;
  String? _token;
  String? _userName;
  String? _email;
  String? _contactPhone;

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

  void setContactPhone(
    String contactPhone,
  ) {
    this._contactPhone = contactPhone;
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
      _email ??= await storage.read(key: emailKey);
      return _email;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getContactPhone() async {
    try {
      _contactPhone ??= await storage.read(key: phoneKey);
      return _contactPhone;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> save({
    required String userName,
    required String refreshToken,
    required String email,
    required String contactPhone,
  }) async {
    try {
      await storage.write(key: rJTW, value: refreshToken);
      await storage.write(key: userNameKey, value: userName);
      await storage.write(key: emailKey, value: email);
      await storage.write(key: phoneKey, value: contactPhone);
      this._userName = userName;
      this._email = email;
      this._contactPhone = contactPhone;
    } catch (e) {
      print(e);
    }
  }
}
