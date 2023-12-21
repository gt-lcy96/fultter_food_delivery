import 'dart:convert';

import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:get/get.dart';

class PaymentRepo {
  final ApiClient apiClient;
  PaymentRepo({required this.apiClient});

  Future<Response> createTestPaymentSheet(
      List<CartModel> orderItems, PlaceOrderBody placeOrderInfo) async {
    var encodedOrderItems = orderItems.map((model) => model.toJson()).toList();

    return await apiClient.postData(
        AppConstants.PAYMENT_CREATE_INTENT_URI,
        jsonEncode({
          'orderItems': encodedOrderItems,
          'placeOrderInfo': placeOrderInfo
        }));
  }

  Future<Response> updatePaymentStatus(
      String status, String clientSecret) async {
    return await apiClient.postData(AppConstants.UPDATE_PAYMENT_URI,
        {'status': status, 'clientSecret': clientSecret});
  }
}
