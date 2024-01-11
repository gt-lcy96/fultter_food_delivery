import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  AppTextField(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.isObscure=false,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.w),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        obscureText: isObscure,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
      ),
    );
  }
}
