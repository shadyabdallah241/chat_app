import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);
  Future<UserModel> login({required String email, required String uid}) async {
    final credential = await authService.signInWithEmailAndPassword(email, uid);

    final firebaseUser = credential.user!;

    return UserModel(password: firebaseUser.uid, email: firebaseUser.email!);
  }

  Future<UserModel> signup({
    required String email,
    required String password,
  }) async {
    final credential = await authService.signUpWithEmailAndPassword(
      email,
      password,
    );

    final firebaseUser = credential.user!;
    return UserModel(password: firebaseUser.uid, email: firebaseUser.email!);
  }
}
