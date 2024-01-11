import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        top: 10.h,
        bottom: 10.h,
      ),
      child: Row(children: [
        appIcon,
        SizedBox(width: 20.w),
        bigText
      ],),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),

          )
        ]
      ),
    );
  }
}
