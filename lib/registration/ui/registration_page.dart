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
    return BlocProvider<RegistrationCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text('registrat'),
            RegistrationEmailInput(),
            RegistrationPasswordInput(),
            ElevatedButton(
              onPressed: _cubit.register,
              child: Text('Зарегестрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
