import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xFFFF74D9)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFFF74D9),
      disabledColor: Color(0xFFEBF1F1),

      scaffoldBackgroundColor: Color.fromARGB(255, 16, 18, 20),
      // errorColor: Color(0xFFdd3135),
      brightness: Brightness.dark,
      hintColor: Color(0xFFbebebe),
      cardColor: Colors.black,
      colorScheme: ColorScheme.dark(primary: color, secondary: color),
      // textButtonTheme:
      //     TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
