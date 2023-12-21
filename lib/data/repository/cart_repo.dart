import 'dart:convert';

import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void removeCache() {
    if(AppConstants.REMOVE_CACHE) {
      sharedPreferences.remove(AppConstants.CART_LIST);
      sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    }
  }

  //convert objects to string because sharedPreference only accepts String
  void addToCartList(List<CartModel> cartList) {
    // test purpose, remove later
    removeCache();
  
    var time = DateTime.now().toString();

    cart = [];
    cartList.forEach((e) {
      e.time = time;
      cart.add(jsonEncode(e));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // prettyPrintJsonEncodedStringList(carts);
    }

    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    
    print("getCartHistoryList().length.toString():  ${getCartHistoryList().length.toString()}");
  }

  void removeCart() {
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
