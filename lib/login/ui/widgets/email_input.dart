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
          initialValue: state.email,
          decoration: InputDecoration(
            hintText: 'введите email',
            // labelText: Strings.loginEmailLabel,
            contentPadding: EdgeInsets.zero,
          ),
          textInputAction: TextInputAction.next,
          onChanged: cubit.emailChange,
        );
      },
    );
  }
}
