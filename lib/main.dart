import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/theme/light_mode.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:chat_app/features/register/cubit/signup_cubit.dart';
import 'package:chat_app/features/register/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginCubit>(), child: MyApp()),
        BlocProvider(create: (context) => sl<SignupCubit>(), child: MyApp()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: RegisterPage(),
    );
  }
}
