import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/pages/main_food/widgets/main_food_widgets.dart';

class FoodPageSlider extends StatefulWidget {
  const FoodPageSlider({super.key});

  @override
  State<FoodPageSlider> createState() => _FoodPageSliderState();
}

class _FoodPageSliderState extends State<FoodPageSlider> {
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 240.h,
    child: PageView.builder(
      controller: pageController,
      itemCount: 5,
      itemBuilder: (context, position) {
        return Container(
          height: 160.h,
          child: buildPageItem(position),
        );
      },
    ),
  );;
  }
}