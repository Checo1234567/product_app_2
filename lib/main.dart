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
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
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
        'check_auth': (_) => const CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'product': (_) => const ProductDetailsScreen(),
        'sign_up': (_) => const SignUpScreen(),
      },
      initialRoute: 'login',
      theme: AppTheme.appLightTheme,
      scaffoldMessengerKey: NotificationService.messengerKey,
    );
  }
}
