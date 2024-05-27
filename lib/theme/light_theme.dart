import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFFE054B8)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFE054B8),
      disabledColor: Color(0xFFBEC3C7),
      scaffoldBackgroundColor: Color(0xFFF3F3F3),
      // errorColor: Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: Color(0xFF9F9F9F),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
