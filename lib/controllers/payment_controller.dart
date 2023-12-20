import 'package:food_delivery/data/repository/payment_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final PaymentRepo paymentRepo;
  PaymentController({required this.paymentRepo});

  String? _clientSecret = null;
  bool _isLoading = false;

  String? get clientSecret => _clientSecret;
  bool get isLoading => _isLoading;

  Future<ResponseModel> createTestPaymentSheet(
      List<CartModel> orderItems) async {
    late ResponseModel responseModel;
    _isLoading = true;
    try {
      Response response = await paymentRepo.createTestPaymentSheet(orderItems);

      if (response.statusCode == 200) {
        _clientSecret = response.body['clientSecret'];
        responseModel = ResponseModel(true, "Successfully Loaded");
      } else {
        _clientSecret = null;
        responseModel = ResponseModel(false, "Failed to load client secret");
      }
      return responseModel;
    } catch (e) {
      print("Exception occurred while creating Test Payment Sheet: $e");
      responseModel = ResponseModel(
          false, "An error occurred while creating Test Payment Sheet");
      return responseModel;
    } finally {
      _isLoading = false;
    }
  }

  Future<ResponseModel> updatePaymentStatus(
      String status, String clientSecret) async {
    late ResponseModel responseModel;
    try {
      Response response = await paymentRepo.updatePaymentStatus(status, clientSecret);
      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, "Successfully updated status");
      } else {
        responseModel = ResponseModel(false, "Failed to update status");
      }
    } catch (e) {
      responseModel = ResponseModel(
          false, "An error occurred while updating payment status");
    }
    return responseModel;
  }
}