import 'package:runway/core/network/service/token_store.dart';
import 'package:runway/core/preference/service/preference_service.dart';

class TokenStoreImpl extends TokenStore {
  final PreferenceService preferenceService;

  TokenStoreImpl(this.preferenceService);
  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<String?> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) {
    // TODO: implement saveTokens
    throw UnimplementedError();
  }
}
