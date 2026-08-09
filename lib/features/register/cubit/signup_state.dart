import 'package:chat_app/core/models/user.dart';
import 'package:equatable/equatable.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  final SignupStatus status;
  final UserModel? user;
  final String? errorMessage;

  const SignupState({required this.status, this.errorMessage, this.user});

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
