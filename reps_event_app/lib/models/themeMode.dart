import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  bool _darkTheme;

  AppTheme(this._darkTheme);

  getTheme() => _darkTheme;
  setTheme(bool theme) => _darkTheme = theme;

  void updateAppTheme(bool theme) {
    _darkTheme = theme;
    notifyListeners();
  }


}