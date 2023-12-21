import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/custom_button.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/order_success.png",
                  width: 100, height: 100),
              SizedBox(height: 45.h),
              Text(
                'You placed the order successfully',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text(
                  'Successful order',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Theme.of(context).disabledColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: CustomButton(
                  buttonText: 'Back to Home',
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
