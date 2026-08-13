import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat_app/core/theme/dark_mode.dart';
import 'package:chat_app/core/theme/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool('isDark') ?? false;

    if (isDark) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }

  Future<void> changeTheme() async {
    final isDark = state.brightness == Brightness.dark;

    final newIsDark = !isDark;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDark', newIsDark);

    if (newIsDark) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }

  bool isDark() {
    return state.brightness == Brightness.dark;
  }

  void setTheme(ThemeData theme) {
    emit(theme);
  }
}
