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
        fontFamily: 'OpenSans'
        ),
  );
}
