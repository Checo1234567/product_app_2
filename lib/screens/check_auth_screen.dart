import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:product_app_login/screens/screens.dart';
import 'package:product_app_login/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('Wait...');
            if (snapshot.data == '') {
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen(),
                      ));
                },
              );
            } else {
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeScreen(),
                      ));
                },
              );
            }

            return Container();
          },
          future: authService.readToken(),
        ),
      ),
    );
  }
}
