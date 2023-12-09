import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Theme.of(context).primaryColor,
        minimumSize: Size((width ?? Dimensions.screenWidth).w,
            height != null ? height! : 50.h),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)));
    return Center(
      child: SizedBox(
        width: (width ?? Dimensions.screenWidth).w,
        height: height ?? 50.h,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Icon(icon,
                        color: transparent
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor),
                  )
                : SizedBox(),
            Text(buttonText,
                style: TextStyle(
                    fontSize: fontSize ?? 16.sp,
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor))
          ]),
        ),
      ),
    );
  }
}
