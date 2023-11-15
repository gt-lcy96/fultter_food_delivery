import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProducList=[];
  List<dynamic> get popularProductList => _popularProducList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    
    if(response.statusCode == 200) {
        _popularProducList = [];
        _popularProducList.addAll(Product.fromJson(response.body[0]).products);
        _isLoaded = true;
        update();
      print("_popularProducList[0].name:  ${_popularProducList[0].name}");
    } else {
      print("response.statusCode:  ${response.statusCode}");
    }
  }
}