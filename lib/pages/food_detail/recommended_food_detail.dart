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
import 'package:food_delivery/pages/food_detail/widgets/expandable_text_widget.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70.h,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcon(icon: Icons.clear)),
            shopping_cart_icon(),
            // AppIcon(icon: Icons.shopping_cart_outlined)
          ]),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
                child: Center(child: bigText(product.name!, fontSize: 26.sp)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5.h, bottom: 7.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                )),
          ),
          pinned: true,
          backgroundColor: AppColors.primaryElement,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              AppConstants.BASE_URL + product.img!,
              // "assets/images/pizza.jpg",
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: ExpandableTextWidget(
                    lineHeight: 1.5, text: product.description!),
              )
            ],
          ),
        ),
      ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: 24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.primaryElement,
                            icon: Icons.remove),
                      ),
                      bigText(
                          "\$ ${product.price!} X ${controller.inCartItems}",
                          color: Colors.black,
                          fontSize: 22.sp),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: 24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.primaryElement,
                            icon: Icons.add),
                      ),
                    ]),
              ),
              Container(
                height: 100.h,
                padding: EdgeInsets.only(
                    top: 15.h, bottom: 15.h, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                    color:
                        AppColors.primarySecondaryElementText.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w * 2),
                      topRight: Radius.circular(20.w * 2),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.w),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primaryElement,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    addToCartWithPrice_button(product,
                        popularProduct: controller),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
