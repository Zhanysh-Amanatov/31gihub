import 'package:finik/repository/authentication_repository.dart';
import 'package:finik/screens/auth/singup/cubit/signup_cubit.dart';
import 'package:finik/screens/auth/singup/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // static Route<void> route() {
  //   return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  // }
  static Page<void> page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
      child: const SignUpForm(),
    );
  }
}
