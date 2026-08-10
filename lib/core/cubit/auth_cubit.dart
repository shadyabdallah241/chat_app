import 'dart:async';

import 'package:chat_app/core/cubit/auth_state.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserModel?>? _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    listenToAuthChanges();
  }

  void listenToAuthChanges() {
    _authSubscription = _authRepository.authStateChanges.listen(
      (user) {
        if (user != null) {
          final userModel = UserModel(
            email: user.email,
            uid: user.uid,
            userName: user.userName,
          );

          emit(Authenticated(userModel));
        } else {
          emit(Unauthenticated());
        }
      },
      onError: (error) {
        emit(AuthError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
