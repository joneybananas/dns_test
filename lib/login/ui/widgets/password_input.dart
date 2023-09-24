import 'package:dns_test/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          decoration: const InputDecoration(
            hintText: 'введите пароль',
            contentPadding: EdgeInsets.zero,
          ),
          textInputAction: TextInputAction.next,
          onChanged: cubit.passwordChange,
        );
      },
    );
  }
}
