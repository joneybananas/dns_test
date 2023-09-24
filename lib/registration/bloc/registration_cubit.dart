import 'package:bloc/bloc.dart';
import 'package:dns_test/registration/domain/registration_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationService registrationService;

  RegistrationCubit(this.registrationService) : super(RegistrationState());

  void emailChange(String? value) => emit(state.copy(email: value));
  void passwordChange(String? value) => emit(state.copy(password: value));

  Future<void> register() async {
    try {
      final q = await registrationService.register(state.email, state.password);
    } on FirebaseAuthException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }
}
