/*External dependencies*/
import 'package:finik/bloc/auth/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/views/common/button_widget.dart';
import 'package:finik/views/common/input_label_widget.dart';
import 'package:finik/views/common/input_widget.dart';
import 'package:finik/views/common/logo_header_description_widget.dart';

class SignUpEmailView extends StatefulWidget {
  const SignUpEmailView({super.key});

  @override
  State<SignUpEmailView> createState() => _SignUpEmailViewState();
}

class _SignUpEmailViewState extends State<SignUpEmailView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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

  Future signUp() async {
    final email = _email.text;
    final password = _password.text;
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredentials.user != null && context.mounted) {
          Navigator.of(context).pushNamed(signUpVerifyEmailRoute);
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password' && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        } else if (e.code == 'email-already-in-use' && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account already exists for that email.'),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
        return null;
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();

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
                  controller: _email,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  icon: const Icon(Icons.email),
                ),
                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                InputWidget(
                  isObscure: true,
                  controller: _password,
                  hintText: 'Enter password',
                  icon: const Icon(Icons.password),
                ),
                SizedBox(height: 250.h),
                _isLoading
                    ? const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFACF709)))
                    : ButtonWidget(
                        btnText: 'Далее',
                        callback: signUp,
                        // callback: () {
                        //   final email = _email.text;
                        //   final password = _password.text;
                        //   print('before bloc');
                        //   authBloc.add(SignUpEvent(email, password));
                        //   print('after bloc');
                        // },
                      ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
