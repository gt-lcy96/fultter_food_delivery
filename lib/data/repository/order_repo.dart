import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.GET_ORDER_LIST_URI);
  }

}