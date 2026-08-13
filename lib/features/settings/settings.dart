import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: .spaceBetween,

            children: [
              Text("Dark Mode", style: TextStyle(fontSize: 16)),
              CupertinoSwitch(
                value: themeCubit.isDark(),
                onChanged: (value) => themeCubit.changeTheme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
