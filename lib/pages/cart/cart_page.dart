import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

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
              AppIcon(
                icon: Icons.home_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryElement,
                iconSize: 20,
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
                child: ListView.builder(
                    itemCount: 10,
                    // separatorBuilder: (context, index) => SizedBox(
                    //       height: 10.w,
                    //     ),
                    itemBuilder: (_, index) {
                      return Container(
                        height: 100.h,
                        width: double.maxFinite,
                        color: Colors.blue,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/chinese_food_1.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20.w),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(child: Container(
                              height: 100.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  bigText("Bitter Orange Juice", color: Colors.black),
                                  smallText("Spicy"),
                                  Row(children: [
                                    bigText("\$ 33.0", color: Colors.redAccent,)
                                  ],)
                                ],
                              )
                            )),
                          ],
                        ),
                      );
                    }),
              )),
        ),
      ]),
    );
  }
}
