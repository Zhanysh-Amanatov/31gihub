/*External dependencies*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/views/common/button_widget.dart';
import 'package:finik/views/common/input_label_widget.dart';
import 'package:finik/views/common/input_widget.dart';
import 'package:finik/views/common/logo_header_description_widget.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => LogInViewState();
}

class LogInViewState extends State<LogInView> {
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

  Future logIn() async {
    final email = _email.text;
    final password = _password.text;
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredentials =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredentials.user != null && context.mounted) {
          Navigator.of(context).pushNamed(homeViewRoute);
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS' && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong email or password'),
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
                  controller: _email,
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
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
                // SizedBox(height: 185.h),
                SizedBox(height: 165.h),
                _isLoading
                    ? const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFACF709)))
                    : ButtonWidget(
                        btnText: 'Далее',
                        routeName: logInLoadingRoute,
                        callback: logIn,
                      ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
