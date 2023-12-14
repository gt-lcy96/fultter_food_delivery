import 'package:food_delivery/data/repository/payment_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final PaymentRepo paymentRepo;
  PaymentController({required this.paymentRepo});

  late String? _clientSecret;
  bool _isLoading = false;

  String? get clientSecret => _clientSecret;
  bool get isLoading => _isLoading;

  Future<ResponseModel> createTestPaymentSheet() async {
    late ResponseModel responseModel;
    _isLoading = true;
    try {    
      Response response = await paymentRepo.createTestPaymentSheet();
      if(response.statusCode == 200) {
        _clientSecret = response.body['clientSecret'];
        responseModel = ResponseModel(true, "Successfully Loaded");
      } else {
        _clientSecret = null;
        responseModel = ResponseModel(false, "Failed to load client secret");
      }
      return responseModel;
    } catch (e) {
      print("Exception occurred while creating Test Payment Sheet: $e");
      responseModel = ResponseModel(false, "An error occurred while creating Test Payment Sheet");
      return responseModel;
    } finally {
      _isLoading = false;
    }
  }
}