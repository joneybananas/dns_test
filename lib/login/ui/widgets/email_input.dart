import 'package:dns_test/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.always,
          initialValue: state.email,
          validator: (value) => _valid(value) ? null : '',
          decoration: const InputDecoration(
            hintText: 'введите email',
            errorStyle: TextStyle(height: 0),
            contentPadding: EdgeInsets.zero,
          ),
          textInputAction: TextInputAction.next,
          onChanged: cubit.emailChange,
        );
      },
    );
  }

  bool _valid(String? value) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '');
  }
}
