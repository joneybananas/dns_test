part of 'registration_cubit.dart';

class RegistrationState {
  final String email;
  final String password;
  final String errorMessage;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  RegistrationState({this.email = '', this.password = '', this.errorMessage = ''});
  RegistrationState copy({
    String? email,
    String? password,
    String? errorMessage,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
