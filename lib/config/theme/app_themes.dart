import 'package:bunche/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

ThemeData themeDarkMode() {
  return ThemeData().copyWith(
    colorScheme: kDarkColorScheme,
    appBarTheme: appBarTheme(),
  );
}

ThemeData themeLightMode() {
  return ThemeData().copyWith(
    colorScheme: kColorScheme,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer);
}

TextTheme textTheme() {
  return ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: kColorScheme.onSecondaryContainer,
      ));
}
