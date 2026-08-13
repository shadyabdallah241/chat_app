import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/login/cubit/login_state.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:chat_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: theme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(Icons.message, color: theme.primary, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
          Spacer(),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == .logout) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 25),
              child: ListTile(
                title: Text("L O G O U T"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  context.read<LoginCubit>().signout();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
