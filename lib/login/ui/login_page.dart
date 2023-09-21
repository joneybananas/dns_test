import 'package:dns_test/login/bloc/login_cubit.dart';
import 'package:dns_test/login/ui/widgets/email_input.dart';
import 'package:dns_test/login/ui/widgets/password_input.dart';
import 'package:dns_test/registration/ui/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = LoginCubit(context.read());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          const Text('Авторизация'),
          const LoginEmailInput(),
          const PasswordFieldWidget(),
          ElevatedButton(
            onPressed: () => _cubit.logIn(),
            child: const Text('Войти'),
          ),
          const Text('Нет аккаунта?'),
          TextButton(
              onPressed: () => Navigator.of(context).push(RegistrationPage.route()),
              child: const Text('Зарегестрируйтесь'))
        ]),
      ),
    );
  }
}
