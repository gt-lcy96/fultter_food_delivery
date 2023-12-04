import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/account/widgets/account_widget.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryElement,
          title: bigText("Profile", fontSize: 24, color: Colors.white),
        ),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              //profile icon
              const AppIcon(
                  icon: Icons.person,
                  backgroundColor: AppColors.primaryElement,
                  iconColor: Colors.white,
                  iconSize: 75,
                  size: 150),
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                          appIcon: const AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.primaryElement,
                              iconColor: Colors.white,
                              iconSize: 25,
                              size: 50),
                          bigText: const BigText(text: "Ahmed")),
                      SizedBox(height: 20.h),
                      //phone
                      AccountWidget(
                          appIcon: const AppIcon(
                              icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: 25,
                              size: 50),
                          bigText: const BigText(text: "0163399434")),
                      SizedBox(height: 20.h),
                      //email
                      AccountWidget(
                          appIcon: const AppIcon(
                              icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: 25,
                              size: 50),
                          bigText: const BigText(text: "loh.cheeyung96@gmail.com")),
                      SizedBox(height: 20.h),
                      //address
                      AccountWidget(
                          appIcon: const AppIcon(
                              icon: Icons.location_on,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: 25,
                              size: 50),
                          bigText: const BigText(text: "Fill in your address")),
                      SizedBox(height: 20.h),
                      //message
                      AccountWidget(
                          appIcon: const AppIcon(
                              icon: Icons.message_outlined,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: 25,
                              size: 50),
                          bigText: const BigText(text: "Message")),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()) { 
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<CartController>().clear();
                            Get.offNamed(RouteHelper.getSignIn());
                          } else {
                            print("you logged out");
                          }

                        },
                        child: AccountWidget(
                            appIcon: const AppIcon(
                                icon: Icons.logout,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: 25,
                                size: 50),
                            bigText: const BigText(text: "Logout")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
