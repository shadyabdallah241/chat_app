import 'package:chat_app/core/validation/cubit/password_validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordValidationCubit extends Cubit<PasswordValidationState> {
  PasswordValidationCubit() : super(const PasswordValidationState());

  bool _hasUppercase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  bool _hasLowercase(String value) {
    return RegExp(r'[a-z]').hasMatch(value);
  }

  bool _hasSpecialChar(String value) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  bool _hasDigits(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  void validatePassword(String password) {
    emit(
      PasswordValidationState(
        hasStartedTyping: password.isNotEmpty,
        hasMinLength: password.length >= 8,
        hasUppercase: _hasUppercase(password),
        hasLowercase: _hasLowercase(password),
        hasSpecialChar: _hasSpecialChar(password),
        hasDigits: _hasDigits(password),
      ),
    );
  }
}
