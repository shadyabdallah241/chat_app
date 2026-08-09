import 'package:chat_app/core/cubit/auth_cubit.dart';
import 'package:chat_app/core/cubit/auth_state.dart';
import 'package:chat_app/features/home/home_page.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is Authenticated) {
          return const HomePage();
        }

        if (state is Unauthenticated) {
          return LoginPage();
        }

        if (state is AuthError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
