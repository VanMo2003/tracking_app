import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../utils/styles.dart';

ThemeData dark({Color color = const Color(0xFF45ADFF)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFFF74D9),
      disabledColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: robotoBold.copyWith(
          fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFF45ADFF),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.black),
        ),
      ),
      scaffoldBackgroundColor: Color.fromARGB(0, 0, 0, 0),
      // errorColor: Color(0xFFdd3135),
      brightness: Brightness.dark,
      hintColor: Color(0xFFEBF1F1),
      cardColor: Colors.black,
      colorScheme: ColorScheme.dark(primary: color, secondary: color),
      // textButtonTheme:
      //     TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
