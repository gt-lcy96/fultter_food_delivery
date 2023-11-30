import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time!)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    // print("cartItemsPerOrder:  ${cartItemsPerOrder}");

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();
    print("itemsPerOrder:  ${itemsPerOrder}");

    var listCounter = 0;

    return Scaffold(
        body: Column(
      children: [
        Container(
            height: 100.h,
            color: AppColors.primaryElement,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bigText(
                    "Cart History",
                    color: Colors.white,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.primaryElement,
                  ),
                ])),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.h),
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: [
                  for (int i = 0; i < cartItemsPerOrder.length; i++)
                    Container(
                        height: 120.h,
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (() {
                              DateTime parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                              var inputDate = DateTime.parse(parsedDate.toString());
                              var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                              var outputDate = outputFormat.format(inputDate);
                              return bigText(outputDate);
                            }()),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children:
                                      List.generate(itemsPerOrder[i], (index) {
                                    if (listCounter <
                                        getCartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index <= 2
                                        ? CartRowItem(
                                            getCartHistoryList, listCounter)
                                        : Container();
                                  }),
                                ),
                                Container(
                                  height: 80.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      smallText("Total", color: AppColors.primaryText),
                                      bigText(itemsPerOrder[i].toString() + " Items", color: AppColors.primaryText),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.w),
                                          border: Border.all(width: 1.w, color: AppColors.primaryElement),
                                        ),
                                        child: smallText("one more", color: AppColors.primaryElement),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

Widget CartRowItem(List<CartModel> getCartHistoryList, int listCounter) {
  return Container(
    height: 70.h,
    width: 70.w,
    margin: EdgeInsets.only(right: 5.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.w),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
            AppConstants.BASE_URL + getCartHistoryList[listCounter - 1].img!),
      ),
    ),
  );
}
