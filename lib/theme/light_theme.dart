import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFFFF74D9)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFE054B8),
      disabledColor: Colors.black,
      scaffoldBackgroundColor: Color.fromARGB(245, 255, 255, 255),
      // errorColor: Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: Color(0xFFBEC3C7),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
