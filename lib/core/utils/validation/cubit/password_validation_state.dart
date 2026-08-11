import 'package:equatable/equatable.dart';

class PasswordValidationState extends Equatable {
  final bool hasStartedTyping;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasSpecialChar;
  final bool hasDigits;

  const PasswordValidationState({
    this.hasStartedTyping = false,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasSpecialChar = false,
    this.hasDigits = false,
  });

  bool get isValid =>
      hasMinLength &&
      hasUppercase &&
      hasLowercase &&
      hasSpecialChar &&
      hasDigits;

  @override
  List<Object?> get props => [
    hasStartedTyping,
    hasMinLength,
    hasUppercase,
    hasLowercase,
    hasSpecialChar,
    hasDigits,
  ];
}
