import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
      primaryColor: const Color(0xFF0043D0),
      useMaterial3: true,
      brightness: Brightness.light,
      canvasColor: Colors.white,
      backgroundColor: Colors.white,
      fontFamily: "Lato",
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColorLight: const Color(0xFFFDBFDD),
    );

ThemeData darkTheme() => ThemeData(
      primaryColor: const Color(0xFF0043D0),
      useMaterial3: true,
      brightness: Brightness.dark,
      canvasColor: Colors.black,
      backgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColorLight: const Color(0xFFFDBFDD),
    );
