import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? inputIcon,
    required Color inputColor,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: inputColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: inputColor),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      prefixIcon: Icon(
        inputIcon,
        color: inputColor,
      ),
    );
  }
}
