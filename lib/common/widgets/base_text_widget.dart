import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';

Widget reusableText(String text,
    {Color color = AppColors.primaryText,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
    overflow = TextOverflow.ellipsis}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize.sp,
    ),
  );
}

Widget smallText(String text,
    {Color color = AppColors.primaryText,
    double fontSize = 12,
    double height = 1.2,
    FontWeight fontWeight = FontWeight.w200,
    overflow = TextOverflow.ellipsis}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize.sp,
      height: height,
    ),
  );
}

Widget bigText(String text,
    {Color color = AppColors.primaryText,
    double fontSize = 20,
    double height = 1.2,
    FontWeight fontWeight = FontWeight.w400,
    overflow = TextOverflow.ellipsis}) {
  return Text(
    text,
    maxLines: 1,
    overflow: overflow,
    style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        height: height,
        fontFamily: 'OpenSans'),
  );
}

class BigText extends 
StatelessWidget {
  const BigText({
      super.key,
      required this.text,
      this.color = AppColors.primaryText,
      this.fontSize = 20,
      this.height = 1.2,
      this.fontWeight = FontWeight.w400,
      this.overflow = TextOverflow.ellipsis});

  final String text;
  final Color color;
  final double fontSize;
  final double height;
  final FontWeight fontWeight;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          height: height,
          fontFamily: 'OpenSans'),
    );
  }
}
