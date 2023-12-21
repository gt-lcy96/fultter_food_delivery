import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });

  // UserModel _userModel = UserModel(
  //       username: "None",
  //       email: "none@gmail.com",
  //       phone: "00000000",
  //       orderCount: 0
  //     );
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {
    // _isLoading = true;
    late ResponseModel responseModel;
    try {
    Response response = await userRepo.getUserInfo();
    // _isLoading = true;
    
    if(response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "successfully");
    }else{
      // _isLoading=false;
      print("did not get user data in userController");
      responseModel = ResponseModel(false, response.statusText!);
    }
    } catch (e) {
      // Handle exceptions here
      print("Exception occurred while fetching user info: $e");
      responseModel = ResponseModel(false, "An error occurred while fetching user info");
    }  finally {
      // _isLoading = false;
      update();
    }
    return responseModel;
  }
}