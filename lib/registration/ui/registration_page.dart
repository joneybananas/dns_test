import 'package:dns_test/common_widgets/snacbars.dart';
import 'package:dns_test/registration/bloc/registration_cubit.dart';
import 'package:dns_test/registration/ui/widgets/email_input.dart';
import 'package:dns_test/registration/ui/widgets/password_imput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RegistrationPage());

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late RegistrationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = RegistrationCubit(context.read());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<RegistrationCubit, RegistrationState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showErrorSnackBar(context, state.errorMessage);
            }
          },
          listenWhen: (previous, current) => previous.errorMessage != current.errorMessage,
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Регестрация'),
                const RegistrationEmailInput(),
                const SizedBox(height: 8),
                const RegistrationPasswordInput(),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _cubit.state.isValid ? _cubit.register : null,
                  child: const Text('Зарегестрироваться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
