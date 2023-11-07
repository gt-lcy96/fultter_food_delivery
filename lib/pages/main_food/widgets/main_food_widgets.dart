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

Widget pageViewSmallBlock() {
  return Container(
    height: 120.h,
    width: 280.w,
    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10.0,
              spreadRadius: 0.5),
        ]),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bigText("Chinese Side", fontSize: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingList(),
              smallText("4.5"),
              smallText("1287 comments"),
            ],
          ),
          IconStatusList('Normal', '1.7km', '32min'),
        ],
      ),
    ),
  );
}

Widget IconStatusList(status, distance, time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      NamedIcon(Icons.circle_sharp, status, color: Colors.yellow),
      NamedIcon(Icons.location_on, distance),
      NamedIcon(Icons.access_time_rounded, time, color: Colors.red[200]),
    ],
  );
}

Widget RatingList() {
  return Row(
    children: List.generate(5, (index) {
      return Icon(Icons.star, color: AppColors.primaryElement);
    }),
  );
}

Widget NamedIcon(icon, text, {color = AppColors.primaryElement}) {
  return Row(children: [
    Icon(
      icon,
      color: color,
    ),
    Text(text)
  ]);
}
