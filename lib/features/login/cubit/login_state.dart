import 'package:chat_app/core/models/user.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure, logout }

class LoginState extends Equatable {
  final LoginStatus status;
  final UserModel? user;
  final String? errorMessage;

  const LoginState({required this.status, this.errorMessage, this.user});

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
