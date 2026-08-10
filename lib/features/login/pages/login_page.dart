import 'package:chat_app/core/widgets/app_button.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:chat_app/features/home/home_page.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/login/cubit/login_state.dart';
import 'package:chat_app/features/register/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }

                if (state.status == LoginStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Login failed'),
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
                      context.read<LoginCubit>().login(
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
                        "Not a member? ",
                        style: TextStyle(color: theme.primary),
                      ),
                      InkWell(
                        child: Text(
                          " Register now",
                          style: TextStyle(
                            color: theme.primary,
                            fontWeight: .bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
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
