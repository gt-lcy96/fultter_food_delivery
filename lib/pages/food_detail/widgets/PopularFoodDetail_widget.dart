import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_detail.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food_detail/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

Widget counterWidget() {
  return GetBuilder<PopularProductController>(builder: (popularProudct) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w), color: Colors.white),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            popularProudct.setQuantity(false);
          },
          child: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5.h,
        ),
        bigText(popularProudct.inCartItems.toString()),
        SizedBox(
          width: 5.h,
        ),
        GestureDetector(
          onTap: () {
            popularProudct.setQuantity(true);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ]));
  });
}

Widget detailList(ProductModel product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bigText(product.name!),
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

      ExpandableTextWidget(
          text: product.description!
              ),
    ],
  );
}

Widget addToCartWithPrice_button(ProductModel? product, {PopularProductController? popularProduct}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: AppColors.primaryElement,
      ),
      child: GestureDetector(
        onTap: () {
          popularProduct?.addItem(product!);
        },
        child: bigText("\$${product?.price} | Add to cart",
            color: AppColors.primaryBackground, fontSize: 16.sp),
      ));
}
