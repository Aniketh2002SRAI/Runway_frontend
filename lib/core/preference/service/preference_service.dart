abstract class PreferenceService {
  Future<void> init();

  Future<void> setString({required String key, required String value});
  String? getString({required String key});

  Future<void> setInt({required String key, required int value});
  int? getInt({required String key});

  Future<void> setBool({required String key, required bool value});
  bool? getBool({required String key});

  Future<void> remove({required String key});
  Future<void> clear();
}
