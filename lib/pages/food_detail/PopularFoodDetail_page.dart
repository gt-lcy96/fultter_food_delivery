import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_detail.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});
  final double _imageCoverSize = 325;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: _imageCoverSize.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/Nutritious meal.jpg"),
            )),
          ),
        ),
        Positioned(
            left: 20.w,
            right: 20.w,
            top: 45.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            )),
        Positioned(
          left: 0,
          right: 0,
          top: _imageCoverSize.h - 20.h,
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), // Adjust the values as needed
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            child: _detailList(),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 100.h,
        padding:
            EdgeInsets.only(top: 15.h, bottom: 15.h, left: 20.w, right: 20.w),
        decoration: BoxDecoration(
            color: AppColors.primarySecondaryElementText.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w * 2),
              topRight: Radius.circular(20.w * 2),
            )),
        child: Row(
          children: [
            counterWidget(),
          ],
        ),
      ),
    );
  }
}

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
        bigText("0"),
        const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ]));
}

Widget _detailList() {
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
