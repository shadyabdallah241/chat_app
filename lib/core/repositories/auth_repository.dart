import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);
  Future<UserModel> login({required String email, required String uid}) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email,
      uid,
    );

    final firebaseUser = credential.user!;

    return UserModel(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  Future<UserModel> signup({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signUpWithEmailAndPassword(
      email,
      password,
    );

    final firebaseUser = credential.user!;
    return UserModel(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  Stream<UserModel?> get authStateChanges {
    return _authService.authStateChange.map((user) {
      if (user == null) {
        return null;
      }
      return UserModel(uid: user.uid, email: user.email.toString());
    });
  }

  Future<void> signout() async {
    _authService.signout;
  }
}
