import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: .center,
            children: [
              Center(child: Text("Home Page")),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().signout();
                },
                child: Text("Signout"),
              ),
            ],
          );
        },
      ),
    );
  }
}
