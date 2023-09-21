import 'package:bloc/bloc.dart';
import 'package:dns_test/login/domain/login_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRep;
  LoginCubit(this.loginRep) : super(LoginState());

  void emailChange(String? value) => emit(state.copy(email: value));
  void passwordChange(String? value) => emit(state.copy(password: value));

  void logIn() {
    loginRep.login(state.email, state.password);
  }
}
