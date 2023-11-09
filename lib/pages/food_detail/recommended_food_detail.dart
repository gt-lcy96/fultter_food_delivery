import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';
import 'package:food_delivery/pages/food_detail/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          toolbarHeight: 70.h,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ]),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
                child: Center(child: bigText("Pizza", fontSize: 26.sp)),
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
            background: Image.asset(
              "assets/images/pizza.jpg",
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
                      lineHeight: 1.5,
                      text:
                          "In the ever-expanding realm of culinary delights, few dishes can claim to have achieved the iconic status that pizza enjoys. Picture this: a symphony of flavors, a harmony of textures, all orchestrated on a canvas of perfectly baked dough. Welcome to Pizza Paradise, where each slice is a passport to a world of gastronomic ecstasy.At the heart of our menu lies a commitment to quality ingredients. Our dough is a labor of love, crafted with precision and patience to achieve the ideal balance of chewiness and crispiness. The foundation of any good pizza, our dough serves as the canvas upon which we paint a masterpiece of flavors."))
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                      iconSize: 24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.primaryElement,
                      icon: Icons.remove),
                  bigText("\$12.88" + "  X  " + "0",
                      color: Colors.black, fontSize: 22.sp),
                  AppIcon(
                      iconSize: 24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.primaryElement,
                      icon: Icons.add),
                ]),
          ),
          Container(
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
                addToCartWithPrice_button(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
