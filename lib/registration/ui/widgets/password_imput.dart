import 'package:dns_test/registration/bloc/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPasswordInput extends StatelessWidget {
  const RegistrationPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrationCubit>();

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          decoration: const InputDecoration(
            hintText: 'введите пароль',
            // labelText: Strings.loginEmailLabel,
            contentPadding: EdgeInsets.zero,
          ),
          textInputAction: TextInputAction.next,
          onChanged: cubit.passwordChange,
        );
      },
    );
  }
}
