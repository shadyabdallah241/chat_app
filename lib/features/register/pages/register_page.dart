import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/utils/validation/app_validators.dart';
import 'package:chat_app/core/utils/validation/cubit/password_validation_cubit.dart';
import 'package:chat_app/core/utils/validation/cubit/password_validation_state.dart';
import 'package:chat_app/core/widgets/app_button.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:chat_app/features/home/home_page.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:chat_app/features/register/cubit/signup_cubit.dart';
import 'package:chat_app/features/register/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SignupCubit>()),
        BlocProvider(create: (context) => PasswordValidationCubit()),
      ],
      child: Scaffold(
        backgroundColor: theme.surface,
        body: SingleChildScrollView(
          child: Center(
            child: BlocListener<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.status == .loading) {
                  Center(child: CircularProgressIndicator());
                }
                if (state.status == .success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }

                if (state.status == .failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? "Signup failed"),
                    ),
                  );
                }
              },
              child: BlocBuilder<PasswordValidationCubit, PasswordValidationState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message, size: 60, color: theme.primary),

                        const SizedBox(height: 25),

                        Text(
                          "Let's create an account for you",
                          style: TextStyle(color: theme.primary),
                        ),

                        const SizedBox(height: 12),

                        AppTextField(
                          hintText: "UserName",
                          controller: _userNameController,
                          validator: AppValidators.userName,
                        ),

                        const SizedBox(height: 12),

                        const SizedBox(height: 12),

                        AppTextField(
                          hintText: "Email",
                          controller: _emailController,
                          validator: AppValidators.email,
                        ),

                        const SizedBox(height: 12),

                        AppTextField(
                          hintText: "Password",
                          isPassword: true,
                          controller: _passwordController,
                          validator: (value) => AppValidators.password(
                            value,
                            context.read<PasswordValidationCubit>().state,
                          ),
                          onChanged: (value) {
                            context
                                .read<PasswordValidationCubit>()
                                .validatePassword(value);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              BlocBuilder<
                                PasswordValidationCubit,
                                PasswordValidationState
                              >(
                                builder: (context, state) {
                                  if (!state.hasStartedTyping) {
                                    return const SizedBox.shrink();
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: Column(
                                      spacing: 8,
                                      children: [
                                        const SizedBox(height: 2),
                                        PasswordRequirement(
                                          text: "At least 8 characters",
                                          isValid: state.hasMinLength,
                                        ),

                                        PasswordRequirement(
                                          text: "At least one uppercase letter",
                                          isValid: state.hasUppercase,
                                        ),

                                        PasswordRequirement(
                                          text: "At least one lowercase letter",
                                          isValid: state.hasLowercase,
                                        ),

                                        PasswordRequirement(
                                          text: "At least one number",
                                          isValid: state.hasDigits,
                                        ),

                                        PasswordRequirement(
                                          text:
                                              "At least one special character",
                                          isValid: state.hasSpecialChar,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                        ),

                        const SizedBox(height: 12),

                        AppTextField(
                          hintText: "Confirm Password",
                          isPassword: true,
                          controller: _confirmController,
                          validator: (value) => AppValidators.confirmPassword(
                            value,
                            _passwordController.text,
                          ),
                        ),

                        const SizedBox(height: 25),

                        AppButton(
                          text: "Register",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignupCubit>().signup(
                                _emailController.text,
                                _passwordController.text,
                                _userNameController.text,
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account? ",
                              style: TextStyle(color: theme.primary),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                " Login now",
                                style: TextStyle(
                                  color: theme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordRequirement extends StatelessWidget {
  const PasswordRequirement({
    super.key,
    required this.text,
    required this.isValid,
  });

  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          isValid ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          color: isValid ? Colors.green : Colors.grey,
        ),
        Text(
          text,
          style: TextStyle(color: isValid ? Colors.green : Colors.grey),
        ),
      ],
    );
  }
}
