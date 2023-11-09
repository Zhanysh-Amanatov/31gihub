/*Extenral dependencies*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
/*Local dependencies*/

class LogoHeaderDescriptionWidget extends StatelessWidget {
  final String header;
  final String description;
  final Alignment logoAlignment;
  final Alignment headerAlignment;
  final Alignment descriptionAlignment;
  final TextAlign alignDescription;
  final TextStyle? style;
  final double? height;

  const LogoHeaderDescriptionWidget({
    super.key,
    required this.header,
    this.description =
        'Карта терминалов от Finik, исследуйте, отмечайте и зарабатывайте баллы',
    this.logoAlignment = Alignment.topCenter,
    this.headerAlignment = Alignment.topCenter,
    this.descriptionAlignment = Alignment.center,
    this.alignDescription = TextAlign.center,
    this.style,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Align(
              alignment: logoAlignment,
              child: SvgPicture.asset('assets/logos/logo.svg'),
            ),
            SizedBox(height: height),
            Align(
              alignment: headerAlignment,
              child: Text(
                header,
                style: style,
              ),
            ),
            Align(
              alignment: descriptionAlignment,
              child: Text(
                textAlign: alignDescription,
                description,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
