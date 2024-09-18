import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  static final AuthenticationRepository instance =
      AuthenticationRepository._internal();

  factory AuthenticationRepository() => instance;

  AuthenticationRepository._internal()
      : _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  Future<firebase_auth.UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future<firebase_auth.UserCredential> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred;
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendVerificationEmail() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  Future<void> sendEmailToResetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signUpWithCredentials(
      {required firebase_auth.OAuthCredential credential}) async {
    await _firebaseAuth.signInWithCredential(credential);
  }
}
