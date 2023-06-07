import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 235, 103, 44);

  static final ThemeData appLightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: primary,
    appBarTheme: const AppBarTheme(elevation: 0, color: primary),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: primary,
    )),
    scaffoldBackgroundColor: Colors.grey[300],
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 5,
    ),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: primary,
    //     shape: const StadiumBorder(),
    //     elevation: 2,
    //   ),
    // ),
    // inputDecorationTheme: const InputDecorationTheme(
    //   floatingLabelStyle: TextStyle(
    //     color: primary,
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: primary),
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: primary),
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.red),
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.red),
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    // ),
  );
}
