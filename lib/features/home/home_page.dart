import 'package:chat_app/core/cubit/auth_cubit.dart';
import 'package:chat_app/core/cubit/auth_state.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: .center,
            children: [
              Row(
                children: [
                  Center(child: Text("Home Page ")),
                  if (state is Authenticated) Text(state.user.userName ?? ""),
                ],
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<LoginCubit>().signout();
                    },
                    child: Text("Signout"),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
