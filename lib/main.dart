import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:chat_app/core/theme/cubit/theme_state.dart';
import 'package:chat_app/features/auth/auth_gate/auth_gate.dart';
import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const AuthGate(),
        );
      },
    );
  }
}
