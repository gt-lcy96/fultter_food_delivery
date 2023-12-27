import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/common/widgets/customLoader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/account/widgets/account_widget.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryElement,
        title: bigText("Profile", fontSize: 24, color: Colors.white),
        leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Navigate to a different screen or pop the current screen.
              Get.offNamed(RouteHelper.getInitial());
            },
          ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
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
                                        backgroundColor:
                                            AppColors.primaryElement,
                                        iconColor: Colors.white,
                                        iconSize: 25,
                                        size: 50),
                                    bigText: BigText(
                                        text:
                                            userController.userModel.username)),
                                SizedBox(height: 20.h),
                                //phone
                                AccountWidget(
                                    appIcon: const AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: 25,
                                        size: 50),
                                    bigText: BigText(
                                        text: userController.userModel.phone)),
                                SizedBox(height: 20.h),
                                //email
                                AccountWidget(
                                    appIcon: const AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: 25,
                                        size: 50),
                                    bigText: BigText(
                                      text: userController.userModel.email,
                                    )),
                                SizedBox(height: 20.h),
                                //address
                                GetBuilder<LocationController>(
                                  builder: (locationController) {
                                    if(_userLoggedIn && locationController.addressList.isEmpty) {
                                      return GestureDetector(
                                        onTap: (){
                                          Get.toNamed(RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                            appIcon: const AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize: 25,
                                                size: 50),
                                            bigText: const BigText(
                                                text: "Fill in your address")),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: (){
                                          Get.toNamed(RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                            appIcon: const AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize: 25,
                                                size: 50),
                                            bigText: const BigText(
                                                text: "Your address")),
                                      );
                                    }
                                  },
                                ),
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
                                  onTap: () {
                                    //logout
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.find<CartController>().clear();
                                      Get.find<LocationController>().clearAddressList();
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
                  )
                //Custom Loader and SignInButton
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLoader(),
                      SizedBox(height: 30.h),
                      SignInButton(),
                    ],
                  ))
            : LoginPrompt();
      }),
    );
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
