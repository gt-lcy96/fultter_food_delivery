import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

Widget mainTitleBar() {
  return Container(
    width: 350.w,
    height: 100.h,
    child: Stack(
      children: [
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            child: Column(
              children: [
                reusableText(
                  "Bangladesh",
                  fontSize: 18.sp,
                  color: AppColors.primaryElement,
                ),
                Row(
                  children: [
                    reusableText("Narshingdi", fontSize: 12.sp, fontWeight:FontWeight.normal),
                    Icon(Icons.arrow_drop_down)
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 10.h,
          child: Container(
            margin: EdgeInsets.only(right: 15.w),
            width: 50.w,
            height: 40.h,
            
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Icon(Icons.search, color: AppColors.primaryBackground),
          ),
        )
      ],
    ),
  );
}
