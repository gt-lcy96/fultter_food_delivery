import 'package:flutter/material.dart';
import 'package:food_delivery/pages/main_food/widgets/main_food_widgets.dart';
import 'package:food_delivery/pages/main_food/FoodPageSlider.dart';

class MainFoodPage extends StatelessWidget {
  const MainFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            mainTitleBar(),
            const FoodPageSlider(),
            popularTitleTexts(),
          ],
        ),
      ),
    );
  }
}
