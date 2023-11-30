/*External dependencies*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/bloc/auth/authentication_bloc.dart';
import 'package:finik/bloc/formBloc/form_bloc.dart';
import 'package:finik/screens/common/button_widget.dart';
// import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/view_routes/routes.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormsValidate>(listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(errorMessage: state.errorMessage));
          } else if (state.isFormValid && !state.isLoading) {
            context.read<AuthenticationBloc>().add(AuthenticationStarted());
            context.read<FormBloc>().add(const FormSucceeded());
          } else if (state.isFormValidateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fill the data correctly!'),
              ),
            );
          }
        }),
        BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: ((context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(homeViewRoute, (route) => false);
          }
        }))
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Form(
                child: Column(children: [
                  LogoHeaderDescriptionWidget(
                    header: 'Регистрация',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NeueMachina',
                      color: Colors.white70,
                    ),
                    height: 8.h,
                  ),
                  SizedBox(height: 32.h),
                  // const InputLabelWidget(
                  //     inputLabel: 'Нам нужна только ваша почта'),
                  SizedBox(height: 16.h),
                  const _EmailField(),
                  // BlocBuilder<FormBloc, FormsValidate>(
                  //   builder: (context, state) {
                  //     return InputWidget(
                  //       inputType: TextInputType.emailAddress,
                  //       hintText: 'Enter email',
                  //       icon: const Icon(Icons.email),
                  //       onChanged: (value) {
                  //         context.read()<FormBloc>().add(EmailChanged(value));
                  //       },
                  //       labelText: 'Email',
                  //       helperText:
                  //           'A complete, valid email e.g. joe@gmail.com',
                  //       errorText: !state.isEmailValid
                  //           ? 'Please ensure the email entered is valid'
                  //           : null,
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 16.h),
                  // const InputLabelWidget(inputLabel: 'Введите пароль'),
                  SizedBox(height: 16.h),
                  const _PasswordField(),
                  // BlocBuilder<FormBloc, FormsValidate>(
                  //   builder: (context, state) {
                  //     return InputWidget(
                  //       isObscure: true,
                  //       hintText: 'Enter password',
                  //       icon: const Icon(Icons.password),
                  //       onChanged: (value) {
                  //         context.read<FormBloc>().add(PasswordChanged(value));
                  //       },
                  //       labelText: 'Password',
                  //       errorText: !state.isPasswordValid
                  //           ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  //           : null,
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 250.h),
                  BlocBuilder<FormBloc, FormsValidate>(
                    builder: (context, state) {
                      return state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ButtonWidget(
                              btnText: 'Далее',
                              onPressed: () {
                                print('clicked');
                                state.isFormValid
                                    ? () => context.read<FormBloc>().add(
                                        const FormSubmitted(
                                            value: Status.signUp))
                                    : null;
                              },
                            );
                    },
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => errorMessage!.contains("Please Verify your email")
              ? Navigator.of(context)
                  .pushNamedAndRemoveUntil(carouselRoute, (route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}
