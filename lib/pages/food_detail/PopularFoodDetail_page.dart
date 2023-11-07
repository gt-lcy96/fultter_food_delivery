import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: 350.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/Nutritious meal.jpg"),
              )
            ),
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
          ))
      ]),
    );
  }
}
