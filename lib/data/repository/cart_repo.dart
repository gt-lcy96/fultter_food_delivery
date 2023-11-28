import 'dart:convert';

import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];

  //convert objects to string because sharedPreference only accepts String
  void addToCartList(List<CartModel> cartList) {
    cart=[];
    cartList.forEach((e) {
      cart.add(jsonEncode(e));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }
  
  List<CartModel> getCartList() {
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // prettyPrintJsonEncodedStringList(carts);
    }

    List<CartModel> cartList=[];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList; 
  }

}