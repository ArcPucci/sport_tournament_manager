import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  final SharedPreferences _preferences;

  PreferencesProvider(this._preferences);

  static const _firstInit = "FIRST_INIT_KEY";
  static const _noty = "NOTY_KEY";
  static const _profile = 'PROFILE_KEY';
  static const _premium = "PREMIUM_KEY";

  Future<void> setFirstInit() async {
    await _preferences.setBool(_firstInit, false);
  }

  bool getFirstInit() {
    return _preferences.getBool(_firstInit) ?? true;
  }

  Future<void> setNoty(bool noty) async {
    await _preferences.setBool(_noty, noty);
  }

  bool getNoty() {
    return _preferences.getBool(_noty) ?? true;
  }

  Future<void> setPremium() async {
    await _preferences.setBool(_premium, true);
  }

  bool getPremium() {
    return _preferences.getBool(_premium) ?? false;
  }

  Future<String> saveProfileImage(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(imageFile.path);
    final savedImage = await imageFile.copy("${appDir.path}/$fileName");

    await _preferences.setString(_profile, savedImage.path);
    return savedImage.path;
  }

  String? getProfileImage() {
    return _preferences.getString(_profile);
  }

  Future<void> clearProfileImage() async {
    final path = _preferences.getString(_profile);
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _preferences.remove(_profile);
  }
}
