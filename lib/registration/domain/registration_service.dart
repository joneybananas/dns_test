import 'package:firebase_auth/firebase_auth.dart';

class RegistrationService {
  final FirebaseAuth _auth;

  RegistrationService(this._auth);

  Future<UserCredential> register(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
