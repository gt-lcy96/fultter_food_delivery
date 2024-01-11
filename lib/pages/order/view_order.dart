import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/customLoader.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/pages/order/order_detail_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            child: ListView.separated(
                itemCount: orderList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 2),
                itemBuilder: (context, index) {
                  var itemCount = orderList[index].items?.length ?? 0;

                  var createAt = DateTime.parse(orderList[index].createdAt!);
                  DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
                  return InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getOrderDetail(),
                          arguments: OrderDetailPage(
                            totalAmount: orderList[index].orderAmount!,
                            items: orderList[index].items!,
                            createdAt: dateFormat.format(createAt),
                          )),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...List.generate(
                                              itemCount,
                                              (inner_index) => Text(
                                                  orderList[index]
                                                          .items?[inner_index]
                                                          ?.name
                                                          ?.toString() ??
                                                      '')),
                                          SizedBox(height: 10.h),
                                          Text(
                                            dateFormat.format(createAt),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ]
                                        // [
                                        //   Text("${}")
                                        //   Text("order ID :   ${orderList[index].id}"),
                                        //   // '''jump'''
                                        // ],
                                        ),
                                  ),
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
                                              style: const TextStyle(
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
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          child: Container(
                                              margin: EdgeInsets.all(5.w),
                                              child: const Text("Track Order")),
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
        return const CustomLoader();
      }
    });
  }
}
