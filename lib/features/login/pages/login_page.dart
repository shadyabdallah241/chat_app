import 'package:chat_app/core/widgets/app_button.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key});

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
            SizedBox(height: 25),
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(color: theme.primary),
            ),
            SizedBox(height: 12),
            AppTextField(hintText: "Email", controller: _emailController),
            SizedBox(height: 12),
            AppTextField(
              hintText: "Password",
              isPassword: false,
              controller: _passwordController,
            ),
            SizedBox(height: 25),
            AppButton(
              text: "Login",
              onTap: () {
                //login
                print("Home Page");
              },
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text("Not a member? ", style: TextStyle(color: theme.primary)),
                InkWell(
                  child: Text(
                    " Register now",
                    style: TextStyle(color: theme.primary, fontWeight: .bold),
                  ),
                  onTap: () {
                    print("Register Page");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
