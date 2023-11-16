import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';
import 'package:food_delivery/pages/main_food/main_food_page.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({super.key, required this.pageId});
  final double _imageCoverSize = 325;

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];

    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: _imageCoverSize.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              // image: AssetImage("assets/images/Nutritious meal.jpg"),
              image: NetworkImage(AppConstants.BASE_URL+product.img),
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
                GestureDetector(
                  onTap: (){
                    Get.to(()=> MainFoodPage());
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),
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
            child: detailList(product),
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
            addToCartWithPrice_button(product),
          ],
        ),
      ),
    );
  }
}
