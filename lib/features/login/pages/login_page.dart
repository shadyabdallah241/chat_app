import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(Icons.message, size: 60, color: theme.primary),
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(color: theme.primary),
            ),
            AppTextField(hintText: "Email"),
            SizedBox(height: 12),
            AppTextField(hintText: "Password", isPassword: false),
          ],
        ),
      ),
    );
  }
}
