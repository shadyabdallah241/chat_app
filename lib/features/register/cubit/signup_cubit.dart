import 'package:chat_app/core/repositories/auth_repository.dart';
import 'package:chat_app/features/register/cubit/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepository) : super(const SignupState(status: .initial));
  final AuthRepository authRepository;

  Future<void> signup(String email, String password, String userName) async {
    emit(state.copyWith(status: .loading));

    try {
      final result = await authRepository.signup(
        email: email,
        password: password,
        userName: userName,
      );
      emit(state.copyWith(status: .success, user: result));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: .failure));
    }
  }
}
