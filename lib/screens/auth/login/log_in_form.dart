/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/routes/routes.dart';
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
                const InputWidget(
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  labelText: 'email',
                  icon: const Icon(Icons.email),
                ),
                SizedBox(height: 16.h),
                const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                const InputWidget(
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
                SizedBox(height: 250.h),
                const ButtonWidget(
                  btnText: 'Далее',
                  // routeName: logInLoadingRoute,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
