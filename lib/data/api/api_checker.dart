import 'package:food_delivery/common/widgets/showCustomSnackBar.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignIn());
    } else {
      showCustomSnackBar(response.statusText!);
    }


  }
}