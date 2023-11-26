import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 60.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                icon: Icons.arrow_back_ios,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryElement,
                iconSize: 20,
              ),
              SizedBox(width: 100.w),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.initial);
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.primaryElement,
                  iconSize: 20,
                ),
              ),
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryElement,
                iconSize: 20,
              ),
            ],
          ),
        ),
        Positioned(
          top: 100.h,
          left: 20.w,
          right: 20.w,
          bottom: 0,
          child: Container(
              margin: EdgeInsets.only(top: 15.h),
              // color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        // itemCount: 10,
                        // separatorBuilder: (context, index) => SizedBox(
                        //       height: 10.w,
                        //     ),
                        itemBuilder: (_, index) {
                          return Container(
                            height: 100.h,
                            width: double.maxFinite,
                            // color: Colors.blue,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(_cartList[index].product);
                                    if(popularIndex >= 0){ //if found
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex));
                                    } else {
                                      var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex));
                                    }
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 100.h,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  _cartList[index].img!),
                                          // "assets/images/chinese_food_1.jpg"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20.w),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: Container(
                                        height: 100.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            bigText(_cartList[index].name!,
                                                color: Colors.black),
                                            smallText("Spicy"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                bigText(
                                                  // "\$ ${_cartList[index].price!}",
                                                  _cartList[index]
                                                      .price
                                                      .toString(),
                                                  color: Colors.redAccent,
                                                ),
                                                counterWidget(
                                                    cartController, index),
                                              ],
                                            )
                                          ],
                                        ))),
                              ],
                            ),
                          );
                        });
                  },
                ),
              )),
        ),
      ]),
    );
  }
}

Widget counterWidget(CartController cartController, int index) {
  var cartItem = cartController.getItems[index];
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w), color: Colors.white),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            // popularProudct.setQuantity(false);
            cartController.addItem(cartItem.product!, -1);
          },
          child: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5.h,
        ),
        bigText(cartItem.quantity.toString()),
        // bigText(popularProudct.inCartItems.toString()),
        SizedBox(
          width: 5.h,
        ),
        GestureDetector(
          onTap: () {
            // popularProudct.setQuantity(true);
            cartController.addItem(cartItem.product!, 1);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ]));
}
