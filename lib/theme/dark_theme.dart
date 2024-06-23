import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xFFE054B8)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFFF74D9),
      disabledColor: Colors.white,

      scaffoldBackgroundColor: Color.fromARGB(0, 0, 0, 0),
      // errorColor: Color(0xFFdd3135),
      brightness: Brightness.dark,
      hintColor: Color(0xFFEBF1F1),
      cardColor: Colors.black,
      colorScheme: ColorScheme.dark(primary: color, secondary: color),
      // textButtonTheme:
      //     TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
