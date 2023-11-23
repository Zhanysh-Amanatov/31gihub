/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/bloc/auth/authentication_bloc.dart';
import 'package:finik/view_routes/routes.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';

class SignUpEmailView extends StatefulWidget {
  static String id = 'login_view';
  const SignUpEmailView({super.key});

  @override
  State<SignUpEmailView> createState() => _SignUpEmailViewState();
}

class _SignUpEmailViewState extends State<SignUpEmailView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              key: _formKey,
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
                InputWidget(
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  icon: const Icon(Icons.email),
                ),
                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                InputWidget(
                  isObscure: true,
                  controller: passwordController,
                  hintText: 'Enter password',
                  icon: const Icon(Icons.password),
                ),
                SizedBox(height: 250.h),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSuccessState) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          signUpVerifyEmailRoute, (route) => false);
                    } else if (state is AuthenticationFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is AuthenticationLoadingState
                        ? const CircularProgressIndicator(
                            color: Color(0xFFACF709),
                          )
                        : ButtonWidget(
                            btnText: 'Далее',
                            callback: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                SignUpEvent(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                            },
                          );
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
