import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:get/get.dart';

class ViewOrder extends StatefulWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  void initState() {
    super.initState();
    // Re-initializing the controller
    if (Get.isRegistered<OrderController>()) {
      Get.delete<OrderController>();
    }
    Get.put(OrderRepo(apiClient: Get.find()));
    Get.put(OrderController(orderRepo: Get.find()));
    Get.find<OrderController>().getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      if (orderController.isLoading == false) {
        late List<OrderModel> orderList;
        if (orderController.currentOrderList.isNotEmpty) {
          orderList = widget.isCurrent
              ? orderController.currentOrderList.reversed.toList()
              : orderController.historyOrderList.reversed.toList();
        }
        return SizedBox(
          width: Dimensions.screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () => null,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("order ID :   ${orderList[index].id}"),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryElement,
                                          borderRadius:
                                              BorderRadius.circular(5.w),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(5.h),
                                          child: Text(
                                              "${orderList[index].orderStatus}",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      InkWell(
                                        onTap: () => null,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.w),
                                            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(5.w),
                                            child: Text("Track Order")),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ));
                }),
          ),
        );
      } else {
        return Text("Loeading...");
      }
    });
  }
}
