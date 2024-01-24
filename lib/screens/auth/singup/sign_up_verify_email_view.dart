/*External dependencies*/
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
/*Local dependencies*/
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:finik/routes/routes.dart';

class SignUpVerifyEmailView extends StatefulWidget {
  const SignUpVerifyEmailView({super.key});

  @override
  State<SignUpVerifyEmailView> createState() => _SignUpVerifyEmailViewState();
}

class _SignUpVerifyEmailViewState extends State<SignUpVerifyEmailView> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      debugPrint('Something went wrong');
    }
  }

  Future cancel() async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(homeViewRoute, (_) => false);
    } catch (e) {
      debugPrint('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomeView()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
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
                Text(
                  'A verification email has been sent',
                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                const CircularProgressIndicator(
                  color: Color(0xFFACF709),
                ),
                // LoadingAnimationWidget.threeArchedCircle(
                // color: const Color(0xFFACF709), size: 50),
                SizedBox(height: 16.h),
                Text(
                  'Checking...',
                  style: TextStyle(color: Colors.white70, fontSize: 20.h),
                ),
                // SizedBox(height: 250.h),
                SizedBox(height: 230.h),
                ButtonWidget(
                  btnText: 'Resend email',
                  onPressed: sendVerificationEmail,
                ),
                SizedBox(height: 10.h),
                ButtonWidget(
                  btnText: 'Cancel',
                  onPressed: cancel,
                  bgColor: const Color(0xFF222222),
                  fgColor: const Color(0xFFACF709),
                )
              ],
            ),
          ),
        );
}
