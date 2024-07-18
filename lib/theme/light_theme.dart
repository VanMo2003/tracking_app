import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../utils/styles.dart';

ThemeData light({Color color = const Color(0xFF008FFF)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFE054B8),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: robotoBold.copyWith(
          fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF008FFF),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      disabledColor: Colors.black,
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      // errorColor: Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: Color(0xFFBEC3C7),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
