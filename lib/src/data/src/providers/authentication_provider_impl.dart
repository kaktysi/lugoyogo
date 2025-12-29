import 'package:firebase_auth/firebase_auth.dart';

import '../../data.dart';

class AuthenticationFirebaseProviderImpl implements AuthenticationProvider {
  @override
  Future<void> signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
