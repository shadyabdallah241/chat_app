import 'package:chat_app/core/models/user.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeStates extends Equatable {
  final HomeStatus status;
  final List<UserModel>? users;
  final String? errorMessage;

  const HomeStates({
    required this.status,
    this.users = const [],
    this.errorMessage,
  });

  HomeStates copyWith({
    HomeStatus? status,
    List<UserModel>? users,
    String? errorMessage,
  }) {
    return HomeStates(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, users, errorMessage];
}
