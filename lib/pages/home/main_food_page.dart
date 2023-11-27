import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/widgets/main_food_widgets.dart';
import 'package:food_delivery/pages/home/FoodPageSlider.dart';

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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: recommendedTitleTexts(),
            ),
            Expanded(child: SingleChildScrollView(child: recommendedSuggestList())),
          ],
        ),
      ),
    );
  }
}
