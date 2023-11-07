import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';

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
            child: detailList(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            counterWidget(),
            addToCartWithPrice_button(),
          ],
        ),
      ),
    );
  }
}
