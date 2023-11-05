import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';

Widget reusableText(String text,
    {Color color = AppColors.primaryText,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
    overflow = TextOverflow.ellipsis
    }) {
  return Text(
    text,
    style:
        TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize.sp, overflow: overflow),
  );
}
