import 'package:flutter/material.dart';

final Color mainColor = Colors.amber;
final Color appBarColor = Colors.amber;
final Color markerColor = Colors.amber;

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: mainColor,
    brightness: Brightness.light,
    primary: mainColor,
  ),
  appBarTheme: AppBarTheme(
    color: appBarColor,
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: mainColor,
    brightness: Brightness.dark,
    primary: mainColor,
  ),
);
