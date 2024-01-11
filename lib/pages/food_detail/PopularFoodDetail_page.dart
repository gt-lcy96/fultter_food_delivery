import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String fromPage;
  const PopularFoodDetail(
      {super.key, required this.pageId, required this.fromPage});
  final double _imageCoverSize = 325;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      body: Stack(children: [
        //background image
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
              image: NetworkImage(AppConstants.BASE_URL + product.img),
            )),
          ),
        ),
        //icon widget
        Positioned(
            left: 20.w,
            right: 20.w,
            top: 45.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if ((fromPage == RouteHelper.cart)) {
                        Get.toNamed(RouteHelper.getCart());
                      } else if (fromPage == RouteHelper.initial) {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)),
                shopping_cart_icon(),
              ],
            )),
        //introduction of food
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
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: 100.h,
            padding: EdgeInsets.only(
                top: 15.h, bottom: 15.h, left: 20.w, right: 20.w),
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
                addToCartWithPrice_button(product,
                    popularProduct: popularProduct),
              ],
            ),
          );
        },
      ),
    );
  }
}
