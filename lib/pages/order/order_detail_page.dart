import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/models/cart_model.dart';

class OrderDetailPage extends StatelessWidget {
  final List<CartModel> items;
  final double totalAmount;
  final String createdAt;
  const OrderDetailPage(
      {required this.items,
      required this.totalAmount,
      required this.createdAt,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(createdAt.toString()),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.h),
              padding: EdgeInsets.all(20.h),
              height: 300.h,
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
                  SizedBox(height: 20.h),
                  Container(
                    height: 150.h,
                    width: Dimensions.screenWidth,
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: items.length ?? 0,
                      itemBuilder: (context, index) =>
                          order_statement(items[index]),
                    ),
                  ),
                  // SizedBox(height: 20.h),
                  // order_statement(),
                  // SizedBox(height: 20.h),
                ],
              ),
            ),
            // Total
            Container(
              margin: EdgeInsets.all(20.h),
              padding: EdgeInsets.all(20.h),
              width: Dimensions.screenWidth,
              height: 100.h,
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
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [bigText("Total:"), bigText("SGD ${totalAmount}")],
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0), // Set padding
                minimumSize: Size(200.w, 48.h), // Set button size
                backgroundColor: AppColors.primaryElement
              ),
              onPressed: () => null,
              child: bigText("Contact Us", color: Colors.white),
            ),
          ],
        ));
  }
}

Widget order_statement(CartModel item) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Text("${item.quantity}x"),
    ),
    SizedBox(width: 30.h),
    Expanded(child: Text("${item.name}", style: TextStyle(fontSize: 14.sp))),
    Text("${item.price}"),
  ]);
}
