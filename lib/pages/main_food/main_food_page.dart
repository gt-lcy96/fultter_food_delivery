import 'package:flutter/material.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/pages/main_food/widgets/main_food_widgets.dart';

class MainFoodPage extends StatelessWidget {
  const MainFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            mainTitleBar(),
            foodPageView(),
          ],
        ),
      ),
    );
  }
}
