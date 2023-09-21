part of 'login_cubit.dart';



class  LoginState {
  final String email;
  final String password;

  LoginState({this.email = '', this.password = ''});

  LoginState copy({
    String? email,
    String? password,
}) => LoginState(email: email ?? this.email,password: password ?? this.password,);


}
