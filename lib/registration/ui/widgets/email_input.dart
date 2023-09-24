import 'package:dns_test/registration/bloc/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationEmailInput extends StatelessWidget {
  const RegistrationEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrationCubit>();

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (value) => _valid(value) ? null : '',
          initialValue: state.email,
          decoration: const InputDecoration(
            errorStyle: TextStyle(height: 0),
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

  bool _valid(String? value) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '');
  }
}
