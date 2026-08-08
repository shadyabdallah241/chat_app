import 'package:chat_app/features/models/user.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String errorMessage;
  final User? user;

  const LoginState({
    required this.status,
    required this.errorMessage,
    this.user,
  });

  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
