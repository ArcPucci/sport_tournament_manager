import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';

class AppTextStyles {
  static const _ro = "RussoOne";
  static const _kp = "Kantumruy";

  static final TextStyle ro35_400 = TextStyle(
    fontFamily: _ro,
    fontSize: 35.r,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final TextStyle ts14_400 = TextStyle(
    fontSize: 14.r,
    height: 22 / 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
  );

  static final TextStyle ts14_600 = TextStyle(
    fontSize: 14.r,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle ts16_600 = TextStyle(
    fontSize: 16.r,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle ts17_500 = TextStyle(
    fontSize: 17.r,
    height: 22 / 17,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.43,
    color: Colors.white,
  );

  static final TextStyle ts16_400 = TextStyle(
    fontSize: 16.r,
    height: 22 / 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final TextStyle ts12_500 = TextStyle(
    fontSize: 12.r,
    height: 13 / 12,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle ts12_400 = TextStyle(
    fontSize: 12.r,
    height: 13 / 12,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final TextStyle kp24_700 = TextStyle(
    fontFamily: _kp,
    fontSize: 24.r,
    fontWeight: FontWeight.w700,
    color: AppColors.red,
  );

  static final TextStyle kp20_700 = TextStyle(
    fontFamily: _kp,
    fontSize: 20.r,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
