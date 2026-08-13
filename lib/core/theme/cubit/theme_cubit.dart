import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/theme/dark_mode.dart';
import 'package:chat_app/core/theme/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode);

  void changeTheme() {
    if (state.brightness == Brightness.light) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }

  bool isDark() {
    if (state.brightness == .light) {
      return false;
    }
    return true;
  }

  void setTheme(ThemeData theme) {
    emit(theme);
  }
}
