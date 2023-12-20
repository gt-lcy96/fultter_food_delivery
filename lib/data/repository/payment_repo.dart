import 'dart:convert';

import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:get/get.dart';

class PaymentRepo {
  final ApiClient apiClient;
  PaymentRepo({required this.apiClient});
  
  Future<Response> createTestPaymentSheet(List<CartModel> orderItems) async {
    print("--------------------------------");


    var encoded = orderItems.map((model) => model.toJson()).toList();
    encoded.forEach((value) => prettyPrintJsonDecodedItem(value));
    var encodedOrderItem = jsonEncode({
      'orderItems': encoded
    });
    // prettyPrintJsonDecodedItem({
    //   'orderItems': encoded
    // });
    // prettyPrintJsonEncodedString(encodedOrderItem);

    return await apiClient.postData(AppConstants.PAYMENT_CREATE_INTENT_URI, encodedOrderItem);
  }

  Future<Response> updatePaymentStatus(String status, String clientSecret) async {
    return await apiClient.postData(AppConstants.UPDATE_PAYMENT_URI, {'status': status, 'clientSecret': clientSecret});
  }
}