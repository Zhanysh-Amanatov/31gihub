/*External dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final Color bgColor;
  final Color fgColor;
  final String? routeName;
  final VoidCallback? onPressed;

  const ButtonWidget({
    super.key,
    required this.btnText,
    this.routeName,
    this.onPressed,
    this.fgColor = const Color(0xFF222222),
    this.bgColor = const Color(0xFFACF709),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: 52.h,
      child: TextButton(
        // key: key,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          foregroundColor: MaterialStateProperty.all(fgColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10.h),
          ),
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(btnText),
      ),
    );
  }
}
