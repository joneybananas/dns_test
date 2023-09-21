import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _auth;

  LoginRepository(this._auth);

  Future<UserCredential> login(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
