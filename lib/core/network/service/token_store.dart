abstract class TokenStore {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<void> clear();
}
