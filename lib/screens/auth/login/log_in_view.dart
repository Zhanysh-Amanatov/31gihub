/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Local dependencies*/
import 'package:finik/routes/routes.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/screens/common/show_error_dialog_widget.dart';
import 'package:finik/services/auth/auth_exceptions.dart';
import 'package:finik/services/auth/bloc/auth_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LovinViewState();
}

class _LovinViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
        color: const Color.fromARGB(255, 0, 0, 0),
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
                InputWidget(
                  controller: _email,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  labelText: 'email',
                  icon: const Icon(Icons.email),
                ),
                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                InputWidget(
                  controller: _password,
                  inputType: TextInputType.visiblePassword,
                  hintText: 'Enter password',
                  icon: const Icon(Icons.password),
                  isObscure: true,
                  labelText: 'password',
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
                SizedBox(height: 200.h),
                ButtonWidget(
                  btnText: 'Далее',
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      context.read<AuthBloc>().add(AuthEventLogIn(
                            email,
                            password,
                          ));
                    } on UserNotFoundAuthException {
                      await showErrorDialog(
                        context,
                        'User not found',
                      );
                    } on WrongPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Wrong password',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        'Authentication error',
                      );
                    }
                  },
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
