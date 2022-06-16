import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode get currentMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static get lightTheme {
    // return ThemeData(
    //   primaryColor: Colors.purple,
    //   primarySwatch: Colors.purple,
    // );
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.green.withBlue(5),
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black87,
        primaryVariant: Colors.black87,
        secondaryVariant: Colors.black12,
        background: Colors.orange,
        onBackground: Colors.white,
        surface: Color(0xFFA5D6A7),
        onSurface: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }

  static get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.green.withBlue(10),
        onPrimary: Colors.white,
        secondary: Colors.black87,
        onSecondary: Colors.white,
        primaryVariant: Colors.white,
        secondaryVariant: Colors.black87,
        background: Colors.orange,
        onBackground: Colors.white,
        surface: Color(0xFFA5D6A7),
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
    );
  }
}
