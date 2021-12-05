class TokenStore {
  String _token;

  TokenStore(this._token);

  void setToken(String newToken) {
    this._token = newToken;
  }

  String getToken() {
    return this._token;
  }
}
