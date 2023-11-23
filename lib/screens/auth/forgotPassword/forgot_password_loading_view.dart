/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';

class ForgotPasswordLoadingView extends StatelessWidget {
  const ForgotPasswordLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            Text(
              'An email to reset your password has been sent',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 385.h),
            ButtonWidget(
              btnText: 'Войти',
              callback: () => Navigator.of(context).pushNamed(logInRoute),
            ),
          ]),
        ),
      ),
    );
  }
}
