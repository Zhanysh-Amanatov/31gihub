import 'package:finik/repository/authentication_repository.dart';
import 'package:finik/screens/auth/login/cubit/login_cubit.dart';
import 'package:finik/screens/auth/login/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: const LogInView(),
      ),
    );
  }
}
