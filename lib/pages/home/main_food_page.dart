import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/widgets/main_food_widgets.dart';
import 'package:food_delivery/pages/home/FoodPageSlider.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatelessWidget {
  const MainFoodPage({super.key});

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadResources,
        child: SafeArea(
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
      ),
    );
  }
}
