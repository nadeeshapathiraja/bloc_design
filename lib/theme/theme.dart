import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white10.withOpacity(0.9),
    primary: Colors.deepPurple,
    secondary: Colors.deepPurple.shade300,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.white10,
    primary: Colors.grey,
    secondary: Colors.grey.shade300,
  ),
);
