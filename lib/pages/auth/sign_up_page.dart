import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/common/widgets/app_text_field.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/common/widgets/showCustomSnackBar.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "google.png",
      "twitter.png",
      "facebook.png",
    ];

    void _registration() {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty) {
        showCustomSnackBar("Type in your email address", title: "Email Address");
      } else if(!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address", title: "InValid Email Address");
      } else if(password.isEmpty) {
        showCustomSnackBar("Type in your passnword", title: "Password");
      } else if(password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      } else {
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password
        );
        
        print(signUpBody.email.toString());
      }
    }

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
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: 20.h),
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: 20.h),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration();
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      color: AppColors.primaryElement),
                  child: Center(
                    child: bigText("Sign up", fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              //tag line
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight * 0.01),
              //sign up options
              RichText(
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.sp,
                  ),
                ),
              ),
            
              Wrap(
                children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CircleAvatar(
                            radius: 25.w,
                            backgroundImage:
                                AssetImage("assets/images/" + signUpImages[index]),
                          ),
                    )),
              )
            ],
          ),
        ),
      );
  }
}
