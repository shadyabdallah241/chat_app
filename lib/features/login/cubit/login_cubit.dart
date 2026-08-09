import 'package:chat_app/core/repositories/auth_repository.dart';
import 'package:chat_app/features/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository)
    : super(LoginState(status: LoginStatus.initial));

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final result = await authRepository.login(email: email, uid: password);
      emit(state.copyWith(status: .success, user: result));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: .failure));
    }
  }

  Future<void> signout() async {
    authRepository.signout();
  }
}
