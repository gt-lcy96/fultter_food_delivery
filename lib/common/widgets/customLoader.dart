import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.primaryElement
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}