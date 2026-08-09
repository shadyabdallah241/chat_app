import 'package:chat_app/core/cubit/auth_cubit.dart';
import 'package:chat_app/core/repositories/auth_repository.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/register/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(sl()));
}
