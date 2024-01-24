/*External dependencies*/
import 'package:finik/screens/common/show_error_dialog_widget.dart';
import 'package:finik/services/auth/auth_exceptions.dart';
import 'package:finik/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                InputWidget(
                  controller: _email,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  icon: const Icon(Icons.email),
                  labelText: 'Email',
                  helperText: '',
                ),
                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                InputWidget(
                  controller: _password,
                  isObscure: true,
                  hintText: 'Enter password',
                  icon: const Icon(Icons.email),
                  labelText: 'Password',
                  helperText: '',
                ),
                SizedBox(height: 200.h),
                ButtonWidget(
                  btnText: 'Далее',
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      context.read<AuthBloc>().add(AuthEventSignUp(
                            email,
                            password,
                          ));
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Weak password',
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                        'Email is already in use',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                        'Invalid email entered',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(context, 'Failed to register');
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
