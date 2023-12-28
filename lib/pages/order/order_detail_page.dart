import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("24 Dec 2023 at 7:06 PM"),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.h),
            padding: EdgeInsets.all(20.h),
        height: 200.h,
        width: Dimensions.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.h),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: bigText("Order Summary"),
            ),
            SizedBox(height: 10.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text("1x"),
              ),
              SizedBox(width: 30.h),
              Expanded(child: Text("Roasted Chicken", style: TextStyle(fontSize: 14.sp))),
              Text("15.00"),
            ])
          ],
        ),
      )),
    );
  }
}
