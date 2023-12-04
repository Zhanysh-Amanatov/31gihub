/*External dependencies*/
import 'package:finik/screens/auth/login/cubit/login_cubit.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/view_routes/routes.dart';
import 'package:formz/formz.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Container(
          // height: double.infinity,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 0, 0, 0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Form(
                child: Column(children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: LogoHeaderDescriptionWidget(
                      header: 'Вход',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NeueMachina',
                        color: Colors.white70,
                      ),
                      height: 8.h,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  const InputLabelWidget(
                      inputLabel: 'Нам нужна только ваша почта'),
                  SizedBox(height: 16.h),
                  // _EmailInput(),
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return InputWidget(
                          inputType: TextInputType.emailAddress,
                          hintText: 'Enter email',
                          labelText: 'email',
                          icon: const Icon(Icons.email),
                          key: const Key('loginForm_emailInput_textField'),
                          errorText: state.email.displayError != null
                              ? 'invalid email'
                              : null,
                          onChanged: (email) =>
                              context.read<LoginCubit>().emailChanged(email),
                        );
                      }),
                  SizedBox(height: 16.h),
                  const InputLabelWidget(inputLabel: 'Введите пароль'),
                  SizedBox(height: 16.h),
                  // _PasswordInput(),
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return InputWidget(
                          inputType: TextInputType.visiblePassword,
                          hintText: 'Enter password',
                          icon: const Icon(Icons.password),
                          isObscure: true,
                          labelText: 'password',
                          key: const Key('loginForm_passwordInput_textField'),
                          errorText: state.password.displayError != null
                              ? 'invalid password'
                              : null,
                          onChanged: (password) => context
                              .read<LoginCubit>()
                              .passwordChanged(password),
                        );
                      }),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          const Color(0xFFACF709),
                        ),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(forgotPasswordRoute);
                      },
                      child: const Text(
                        'Забыл пароль?',
                      ),
                    ),
                  ),
                  SizedBox(height: 190.h),
                  // _LoginButton(),
                  BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                    return state.status.isInProgress
                        ? const CircularProgressIndicator()
                        : ButtonWidget(
                            key: const Key('loginForm_continue_raisedButton'),
                            btnText: 'Далее',
                            routeName: logInLoadingRoute,
                            onPressed: state.isValid
                                ? () => context
                                    .read<LoginCubit>()
                                    .logInWithCredentials()
                                : null,
                          );
                  })
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              helperText: '',
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color.fromARGB(255, 203, 175, 31),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}
