import 'package:bloc/bloc.dart';
import 'package:dns_test/login/domain/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRep;
  LoginCubit(this.loginRep) : super(LoginState());

  void emailChange(String? value) => emit(state.copy(email: value));
  void passwordChange(String? value) => emit(state.copy(password: value));

  Future<void> logIn() async {
    try {
      await loginRep.login(state.email, state.password);
    } on FirebaseAuthException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }
}
