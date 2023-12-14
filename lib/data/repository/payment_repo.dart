import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';

class PaymentRepo {
  final ApiClient apiClient;
  PaymentRepo({required this.apiClient});
  
  Future<Response> createTestPaymentSheet() async {
    return await apiClient.getData(AppConstants.PAYMENT_CREATE_INTENT_URI);
  }
}