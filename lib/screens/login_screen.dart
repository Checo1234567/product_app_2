import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:product_app_login/providers/providers.dart';
import 'package:product_app_login/widgets/widgets.dart';
import '../ui_elements/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Create a new acount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        //TODO: mantener la referencia al key.
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'example@something.com',
                labelText: 'Email',
                inputIcon: Icons.alternate_email_rounded,
                inputColor: Colors.deepPurple,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                //La palabra reservada 'new'ya no es usada en dart, pero la dejo para hacer de este ejemplo mas explicito posible.
                // ignore: unnecessary_new
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Insert a valid email direction';
              },
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                inputIcon: Icons.lock,
                inputColor: Colors.deepPurple,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'The password must have 6 o more charecters';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.getIsLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (!loginForm.isValidForm()) return;

                      loginForm.setIsLoading = true;

                      await Future.delayed(const Duration(seconds: 2));

                      loginForm.setIsLoading = true;

                      Navigator.pushReplacementNamed(context, 'home');
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: loginForm.getIsLoading
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator())
                    : const Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
