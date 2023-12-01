import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
            child: CircleAvatar(
              radius: 80.w,
              backgroundImage:
                  const AssetImage("assets/images/food_delivery_logo.png"),
              backgroundColor: Colors.white,
            ),
          ),),
          AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
          SizedBox(height:  20.h),
          AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password_sharp),
          SizedBox(height:  20.h),
          AppTextField(textController: nameController, hintText: "Name", icon: Icons.person),
          SizedBox(height:  20.h),
          AppTextField(textController: phoneController, hintText: "Phone", icon: Icons.phone),
          SizedBox(height:  20.h),
        ],
      ),
    );
  }
}
