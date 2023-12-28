import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderRepo orderRepo;
  bool _isLoading = false;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  bool get isLoading => _isLoading;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  OrderController({required this.orderRepo});

  Future<void> getOrderList() async {
    _isLoading = true;
    update();
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body['orders'].forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == "PENDING" ||
            orderModel.orderStatus == "ACCEPTED" ||
            orderModel.orderStatus == "PROCESSING" ||
            orderModel.orderStatus == "HANDOVER" ||
            orderModel.orderStatus == "PICKED_UP") {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }

    _isLoading=false;
    update();
  }
}
