/*External dependencies */
import 'package:firebase_auth/firebase_auth.dart';
/*Local dependencies */
import 'package:finik/view_routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:finik/views/login/common/button_widget.dart';
import 'package:finik/views/login/common/input_label_widget.dart';
import 'package:finik/views/login/common/input_widget.dart';
import 'package:finik/views/login/common/logo_header_description_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    _email = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();

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
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(children: [
              LogoHeaderDescriptionWidget(
                header: 'Новый пароль',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NeueMachina',
                  color: Colors.white70,
                ),
                height: 8.h,
              ),
              SizedBox(height: 32.h),
              const InputLabelWidget(inputLabel: 'Нам нужна только ваша почта'),
              SizedBox(height: 16.h),
              InputWidget(
                controller: _email,
                inputType: TextInputType.emailAddress,
                hintText: 'Enter email',
                icon: const Icon(Icons.email),
              ),
              SizedBox(height: 345.h),
              _isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFACF709)))
                  : ButtonWidget(
                      btnText: 'Далее',
                      callback: forgotPassword,
                    ),
            ]),
          )),
        ),
      ),
    );
  }

  Future forgotPassword() async {
    final email = _email.text;
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (context.mounted) {
          Navigator.of(context).pushNamed(forgotPasswordLoadingRoute);
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong email format'),
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
      }
      return null;
    }
  }
}
