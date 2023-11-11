import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProducList=[];
  List<dynamic> get popularProductList => _popularProducList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200) {
      _popularProducList = [];
      // _popularProducList.addAll();
      update();
    } else {

    }
  }
}