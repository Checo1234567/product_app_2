import 'package:flutter/material.dart';
import 'package:product_app_login/theme/theme.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: AppTheme.primary,
          fontSize: 20,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
