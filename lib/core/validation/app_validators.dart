import 'package:chat_app/core/validation/cubit/password_validation_state.dart';

class AppValidators {
  static String? userName(String? value) {
    final RegExp userNameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    if (value == null || value.isEmpty) {
      return "UserName is required";
    }
    if (!userNameRegex.hasMatch(value)) {
      return "Username is not valid";
    }

    return null;
  }

  static String? email(String? value) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty) {
      return "email is required";
    }
    if (!emailRegex.hasMatch(value)) {
      return "Email is not valid";
    }

    return null;
  }

  static String? password(String? value, PasswordValidationState state) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (!state.hasMinLength ||
        !state.hasUppercase ||
        !state.hasLowercase ||
        !state.hasDigits ||
        !state.hasSpecialChar) {
      return "Password does not meet the requirements";
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    } else if (value != password) {
      return "Password is not match";
    }
    return null;
  }
}
