import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sport_tournament_manager/services/services.dart';

class ConfigProvider extends ChangeNotifier {
  final PreferencesProvider _preferencesProvider;

  bool _noty = true;

  bool get noty => _noty;

  String? _profile;

  String? get profile => _profile;

  bool _premium = false;

  ConfigProvider(this._preferencesProvider) {
    init();
  }

  bool get premium => _premium;

  void init() {
    _noty = _preferencesProvider.getNoty();
    _premium = _preferencesProvider.getPremium();
    _profile = _preferencesProvider.getProfileImage();
  }

  void saveImage(File image) async {
    _profile = await _preferencesProvider.saveProfileImage(image);
    notifyListeners();
  }

  void toggleNoty() {
    _noty = !_noty;
    _preferencesProvider.setNoty(_noty);
    notifyListeners();
  }

  void deleteProfile() async {
    _profile = null;
    await _preferencesProvider.clearProfileImage();
    notifyListeners();
  }

  void buyPremium() async {
    _premium = true;
    await _preferencesProvider.setPremium();
    notifyListeners();
  }
}
