import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProducList=[];
  List<dynamic> get popularProductList => _popularProducList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

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

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(quantity + 1);
    } else {
      _quantity = checkQuantity(quantity - 1);
      print(quantity);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more", backgroundColor: AppColors.primaryElement, colorText: AppColors.primaryBackground);
      return quantity + 1; //return previous negative
    } else if ((_inCartItems + quantity) > AppConstants.COUTNER_MAX_QUANTITY) {
      Get.snackbar("Item count", "You can't add more", backgroundColor: AppColors.primaryElement, colorText: AppColors.primaryBackground);
      if(_inCartItems >= 20) {
        return 0;
      } else {
        return AppConstants.COUTNER_MAX_QUANTITY;
      }
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist=false;
    exist = _cart.existInCart(product);
    print("exist or not: "+ exist.toString());

    if(exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is"+_inCartItems.toString());
  }

  void addItem(ProductModel product) {
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("The id is ${value.id}, The quantity is ${value.quantity}");
      });
      update();
  }

  int get totalItems {
    return _cart.totalItems;
  }  
}