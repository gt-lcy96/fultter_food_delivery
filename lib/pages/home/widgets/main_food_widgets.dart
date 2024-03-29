import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_detail.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

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
              Row(
                children: [
                  bigText("Singapore",
                       fontWeight: FontWeight.normal),
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

Widget pageViewSmallBlock(ProductModel popularProduct) {
  return Container(
    height: 120.h,
    width: 280.w,
    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10.0,
              spreadRadius: 0.5),
        ]),
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bigText(popularProduct.name!, fontSize: 18),
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

Widget recommendedTitleTexts() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: bigText("Recommended"),
      ),
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: bigText("."),
      ),
      Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: smallText('Food paring'),
      )
    ],
  );
}

Widget recommendedSuggestList() {
  return GetBuilder <
      RecommendedProductController>(builder: (recommendedProduct) {
        return recommendedProduct.isLoaded
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index) {
                  var currentRecommendedProduct = recommendedProduct.recommendedProductList[index];
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index, RouteHelper.initial));
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.w),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+currentRecommendedProduct.img!),
                                ),
                              )),
                          Expanded(
                            child: Container(
                              height: 90.h,
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 7.5, top: 7.5, right: 7.5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    bigText(currentRecommendedProduct.name!,
                                        fontSize: 16.sp),
                                    smallText(currentRecommendedProduct.description!),
                                    IconStatusList("Normal", "1.5km", "30mins"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : const CircularProgressIndicator(color: AppColors.primaryElement);
      });
}
