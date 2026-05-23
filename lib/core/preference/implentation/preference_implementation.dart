import 'package:runway/core/preference/service/preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceImpl implements PreferenceService {
  late SharedPreferences _pref;

  @override
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    await _pref.setString(key, value);
  }

  @override
  String? getString({required String key}) {
    return _pref.getString(key);
  }

  @override
  Future<void> setInt({required String key, required int value}) async {
    await _pref.setInt(key, value);
  }

  @override
  int? getInt({required String key}) {
    return _pref.getInt(key);
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    await _pref.setBool(key, value);
  }

  @override
  bool? getBool({required String key}) {
    return _pref.getBool(key);
  }

  @override
  Future<void> remove({required String key}) async {
    await _pref.remove(key);
  }

  @override
  Future<void> clear() async {
    await _pref.clear();
  }
}
