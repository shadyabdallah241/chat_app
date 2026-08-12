import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);
  Future<UserModel> login({required String email, required String uid}) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email,
      uid,
    );

    final firebaseUser = credential.user!;

    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      userName: firebaseUser.displayName ?? "",
    );
  }

  void getCurrentUser() {
    _authService.getCurrentUser();
  }

  Future<UserModel> signup({
    required String email,
    required String password,
    required String userName,
  }) async {
    final credential = await _authService.signUpWithEmailAndPassword(
      email,
      password,
      userName,
    );

    final firebaseUser = credential.user!;
    await firebaseUser.updateDisplayName(userName);
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      userName: firebaseUser.displayName,
    );
  }

  Stream<UserModel?> get authStateChanges {
    return _authService.authStateChange.map((user) {
      if (user == null) {
        return null;
      }
      return UserModel(
        uid: user.uid,
        email: user.email.toString(),
        userName: user.displayName.toString(),
      );
    });
  }

  Future<void> signout() async {
    await _authService.signout;
  }
}
