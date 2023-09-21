import 'package:bloc/bloc.dart';
import 'package:dns_test/registration/domain/registration_service.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationService registrationService;

  RegistrationCubit(this.registrationService) : super(RegistrationState());

  void emailChange(String? value) => emit(state.copy(email: value));
  void passwordChange(String? value) => emit(state.copy(password: value));

  Future<void> register() async {
    final q = registrationService.register(state.email, state.password);
  }
}
