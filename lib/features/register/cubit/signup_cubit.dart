import 'package:chat_app/core/repositories/auth_repository.dart';
import 'package:chat_app/features/register/cubit/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit(this.authRepository)
    : super(SignupState(status: SignupStatus.initial));

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(status: SignupStatus.loading));

    try {
      final result = await authRepository.signup(
        email: email,
        password: password,
      );
      emit(state.copyWith(status: .success, user: result));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: .failure));
    }
  }
}
