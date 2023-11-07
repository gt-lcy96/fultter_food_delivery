import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_detail.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

Widget counterWidget() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w), color: Colors.white),
      child: Row(children: [
        const Icon(
          Icons.remove,
          color: Colors.black,
        ),
        SizedBox(
          width: 5.h,
        ),
        bigText("0"),
        SizedBox(
          width: 5.h,
        ),
        const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ]));
}

Widget detailList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bigText("Salad"),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingList(),
            SizedBox(
              width: 10.w,
            ),
            smallText("4.5"),
            SizedBox(
              width: 15.w,
            ),
            smallText("1153 comments"),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: IconStatusList("Normal", "1.7km", "30min",
            alignment: MainAxisAlignment.spaceBetween),
      ),
      bigText("Introduce"),
      SizedBox(height: 15.h),
      //description
      smallText(
          "This salmon salad is the epitome of versatility. Enjoy it as a light and healthy lunch, a delightful appetizer, or a satisfying dinner. It's a great choice for those who appreciate gourmet flavors and nutritious ingredients.",
          overflow: TextOverflow.visible,
          height: 2.0),
    ],
  );
}

Widget addToCartWithPrice_button() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: AppColors.primaryElement,
      ),
      child: bigText("\$10 | Add to cart",
          color: AppColors.primaryBackground, fontSize: 16.sp));
}
