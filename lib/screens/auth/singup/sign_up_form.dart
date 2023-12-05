/*External dependencies*/
import 'package:finik/screens/auth/singup/cubit/signup_cubit.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/screens/common/button_widget.dart';
// import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/view_routes/routes.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const InputLabelWidget(
                    inputLabel: 'Нам нужна только ваша почта'),
                SizedBox(height: 16.h),
                // const _EmailField(),
                BlocBuilder<SignUpCubit, SignUpState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: ((context, state) {
                    return InputWidget(
                      inputType: TextInputType.emailAddress,
                      hintText: 'Enter email',
                      icon: const Icon(Icons.email),
                      labelText: 'Email',
                      helperText: '',
                      errorText: state.email.displayError != null
                          ? 'invalid email'
                          : null,
                      onChanged: (email) =>
                          context.read<SignUpCubit>().emailChanged(email),
                    );
                  }),
                ),

                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                // const _PasswordField(),
                BlocBuilder<SignUpCubit, SignUpState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: ((context, state) {
                    return InputWidget(
                      isObscure: true,
                      hintText: 'Enter password',
                      icon: const Icon(Icons.email),
                      labelText: 'Password',
                      helperText: '',
                      errorText: state.password.displayError != null
                          ? 'invalid password'
                          : null,
                      onChanged: (password) =>
                          context.read<SignUpCubit>().passwordChanged(password),
                    );
                  }),
                ),
                SizedBox(height: 250.h),
                BlocBuilder<SignUpCubit, SignUpState>(
                    builder: ((context, state) {
                  return state.status.isInProgress
                      ? const CircularProgressIndicator(
                          color: Color(0xFFACF709),
                        )
                      : ButtonWidget(
                          key: const Key('signUpForm_continue_raisedButton'),
                          btnText: 'Далее',
                          onPressed: () {
                            if (state.isValid) {
                              context.read<SignUpCubit>().signUpFormSubmitted();
                            } else {
                              null;
                            }
                          },
                        );
                }))
              ]),
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
