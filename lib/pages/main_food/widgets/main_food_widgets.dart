import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

Widget mainTitleBar() {
  return Container(
    width: 350.w,
    height: 70.h,
    child: Stack(
      children: [
        Positioned(
          left: 20,
          top: 20,
            child: Column(
              children: [
                bigText(
                  "Bangladesh",
                  color: AppColors.primaryElement,
                ),
                Row(
                  children: [
                    reusableText("Narshingdi",
                        fontSize: 12.sp, fontWeight: FontWeight.normal),
                    const Icon(Icons.arrow_drop_down)
                  ],
                )
              ],
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
            child: const Icon(Icons.search, color: AppColors.primaryBackground),
          ),
        )
      ],
    ),
  );
}

Widget foodPageView() {
  return SizedBox(
    height: 320,
    child: PageView.builder(
      itemCount: 5,
      itemBuilder: (context, position){
      return Container(
        height: 220,
        color: Colors.red,
        child:  _buildPageItem(position),
        );
    },
    ),
  );
}

Widget _buildPageItem(int index) {
  return Container(
    height: 220,
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      color: Colors.blue
    ),
  );
}