/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/screens/common/button_widget.dart';
// import 'package:finik/screens/common/input_label_widget.dart';
import 'package:finik/screens/common/input_widget.dart';
import 'package:finik/screens/common/logo_header_description_widget.dart';
import 'package:finik/view_routes/routes.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

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
                // const InputLabelWidget(
                //     inputLabel: 'Нам нужна только ваша почта'),
                SizedBox(height: 16.h),
                // const _EmailField(),

                const InputWidget(
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  helperText: 'A complete, valid email e.g. joe@gmail.com',
                ),

                SizedBox(height: 16.h),
                // const InputLabelWidget(inputLabel: 'Введите пароль'),
                SizedBox(height: 16.h),
                // const _PasswordField(),

                const InputWidget(
                  isObscure: true,
                  hintText: 'Enter password',
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                ),

                SizedBox(height: 250.h),
                ButtonWidget(
                  btnText: 'Далее',
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => errorMessage!.contains("Please Verify your email")
              ? Navigator.of(context)
                  .pushNamedAndRemoveUntil(carouselRoute, (route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
