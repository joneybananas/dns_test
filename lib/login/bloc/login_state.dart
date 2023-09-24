part of 'login_cubit.dart';

class LoginState {
  final String email;
  final String password;
  final String errorMessage;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState({this.email = '', this.password = '', this.errorMessage = ''});

  LoginState copy({
    String? email,
    String? password,
    String? errorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
