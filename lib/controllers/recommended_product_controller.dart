import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProducList=[];
  List<dynamic> get recommendedProductList => _recommendedProducList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    
    if(response.statusCode == 200) {
        _recommendedProducList = [];
        _recommendedProducList.addAll(Product.fromJson(response.body[0]).products);
        _isLoaded = true;
        update();
    } else {
      print("response.statusCode:  ${response.statusCode}");
      print("could not get products recommended");
    }
  }
}