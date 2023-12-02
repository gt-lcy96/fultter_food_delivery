import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/app_text_field.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: CircleAvatar(
                  radius: 80.w,
                  backgroundImage:
                      const AssetImage("assets/images/food_delivery_logo.png"),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            //Welcome
            Container(
                margin: EdgeInsets.only(left: 20.w),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 70.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    smallText("Sign into your account", fontSize: 20.sp, color: Colors.grey[500]!, fontWeight: FontWeight.bold)
                  ],
                )),
            SizedBox(height: 20.h),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: 20.h),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp),

            SizedBox(height: 20.h),
            //tag line
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                    text: "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 20.w)
              ],
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            //sign in button
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: AppColors.primaryElement),
              child: Center(
                child: bigText("Sign In", fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.03),
            RichText(
              text: TextSpan(
                  text: "Don't have an account",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20.sp,
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                        text: "  Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          fontSize: 20.sp,
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
