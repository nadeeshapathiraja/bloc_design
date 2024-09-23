import 'package:bloc_patterns/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themedata = lightMode;

  ThemeData get getThemeMode => _themedata;

  set setThemeMode(ThemeData themeData) {
    _themedata = themeData;
    notifyListeners();
  }

  void toggleTap() {
    Logger().w(_themedata.toString());
    if (_themedata == lightMode) {
      Logger().d("test 1");
      _themedata = darkMode;
    } else {
      Logger().d("test 2");
      _themedata = lightMode;
    }
    notifyListeners();
  }
}
