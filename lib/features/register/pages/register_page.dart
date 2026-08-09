import 'package:chat_app/core/widgets/app_button.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:chat_app/features/home/home_page.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:chat_app/features/register/cubit/signup_cubit.dart';
import 'package:chat_app/features/register/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return BlocListener<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.status == .success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }
                if (state.status == .failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? "login failed"),
                    ),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.message, size: 60, color: theme.primary),
                  SizedBox(height: 25),
                  Text(
                    "Let's create an account for you",
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
                  SizedBox(height: 12),
                  AppTextField(
                    hintText: "Confirm Password",
                    isPassword: false,
                    controller: _confirmController,
                  ),
                  SizedBox(height: 25),
                  AppButton(
                    text: "Register",
                    onTap: () {
                      context.read<SignupCubit>().signup(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Have an account? ",
                        style: TextStyle(color: theme.primary),
                      ),
                      InkWell(
                        child: Text(
                          " Login now",
                          style: TextStyle(
                            color: theme.primary,
                            fontWeight: .bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
