import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 0, 113, 197),
        iconTheme: IconThemeData(
          color: Colors.black,
        )
    )
);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff15161a),
    appBarTheme: const AppBarTheme(elevation: 0,
      backgroundColor: Color(0xff15161a),)

);