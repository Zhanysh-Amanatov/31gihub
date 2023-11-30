/*External dependencies*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/bloc/auth/authentication_bloc.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/view_routes/routes.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => LogInViewState();
}

class LogInViewState extends State<LogInView> {
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
        // height: double.infinity,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  controller: passwordController,
                  inputType: TextInputType.visiblePassword,
                  hintText: 'Enter password',
                  icon: const Icon(Icons.password),
                  isObscure: true,
                ),
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
                SizedBox(height: 165.h),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSuccessState) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          homeViewRoute, (route) => false);
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
                            routeName: logInLoadingRoute,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                LoginEvent(
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
