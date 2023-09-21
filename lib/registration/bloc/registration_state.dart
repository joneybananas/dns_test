part of 'registration_cubit.dart';

class RegistrationState {
  final String email;
  final String password;
  RegistrationState({this.email = '', this.password = ''});
  RegistrationState copy({
    String? email,
    String? password,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
      );
}
