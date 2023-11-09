import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.size = 40,
    this.iconColor = const Color(0xFF756d54),
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconSize = 16,
  });

  final IconData icon;
  final double size;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.w / 2),
        color: backgroundColor,
      ),
      child: Icon(icon, color: iconColor, size: iconSize.w),
    );
  }
}
