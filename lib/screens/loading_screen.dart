import 'package:flutter/material.dart';
import 'package:product_app_login/theme/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
