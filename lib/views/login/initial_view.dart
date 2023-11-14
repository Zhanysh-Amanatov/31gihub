/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/views/common/button_widget.dart';
import 'package:finik/views/common/logo_header_description_widget.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Column(children: [
          LogoHeaderDescriptionWidget(
            logoAlignment: Alignment.topLeft,
            headerAlignment: Alignment.topLeft,
            height: 24.h,
            header: 'Финик Карта',
            description:
                'Отмечай места на карте где нет нашего терминала, мы поставим его, а тебе пришлем бонусы которые ты сможешь обменять на реальные призы',
            alignDescription: TextAlign.start,
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'NeueMachina',
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 24.h),
          ButtonWidget(
            btnText: 'Войти в аккаунт',
            routeName: logInRoute,
            callback: () => Navigator.of(context).pushNamed(logInRoute),
          ),
          SizedBox(height: 10.h),
          ButtonWidget(
            btnText: 'Регистрация',
            routeName: signUpEmailRoute,
            fgColor: const Color(0xFFACF709),
            bgColor: const Color(0xFF222222),
            callback: () => Navigator.of(context).pushNamed(signUpEmailRoute),
          ),
        ]),
      ),
    );
  }
}
