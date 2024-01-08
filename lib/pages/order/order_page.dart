import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/pages/order/view_order.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<OrderController>()) {
      Get.delete<OrderController>();
    }
    Get.put(OrderRepo(apiClient: Get.find()));
    Get.put(OrderController(orderRepo: Get.find()));

    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My order"),
          backgroundColor: AppColors.primaryElement,
        ),
        body: Get.find<AuthController>().userLoggedIn()
            ? Column(
                children: [
                  Container(
                    width: Dimensions.screenWidth,
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: "current"),
                        Tab(text: "history"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Text("true"),
                        // Text("false"),
                        ViewOrder(isCurrent: true),
                        ViewOrder(isCurrent: false),
                      ],
                    ),
                  )
                ],
              )
            : LoginPrompt());
  }
}

Widget LoginPrompt() {
  return Container(
      child: Center(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: double.maxFinite,
          height: 160.h,
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/sign_in_cont.png")))),
      SignInButton(),
    ],
  )));
}

Widget SignInButton() {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteHelper.getSignIn());
    },
    child: Container(
      width: double.maxFinite,
      height: 40.h,
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: AppColors.primaryElement,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child:
          Center(child: bigText("Sign In", color: Colors.white, fontSize: 20)),
    ),
  );
}
