import 'package:chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/repository/auth_repository.dart';
import 'package:chat_app/features/home/repository/chat_repository.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';
import 'package:chat_app/core/utils/validation/cubit/password_validation_cubit.dart';
import 'package:chat_app/features/home/cubit/home_cubit.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:chat_app/features/register/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));

  sl.registerLazySingleton<ChatService>(() => ChatService());
  sl.registerLazySingleton<ChatRepository>(() => ChatRepository(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<PasswordValidationCubit>(() => PasswordValidationCubit());
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(sl()));
}
