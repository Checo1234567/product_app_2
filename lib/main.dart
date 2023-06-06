import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:product_app_login/screens/screens.dart';
import 'package:product_app_login/services/services.dart';
import 'package:product_app_login/theme/theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductService(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos_app',
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'product': (context) => const ProductDetailsScreen(),
        'sign_up': (context) => const SignUpScreen(),
      },
      initialRoute: 'sign_up',
      theme: AppTheme.appLightTheme,
    );
  }
}
