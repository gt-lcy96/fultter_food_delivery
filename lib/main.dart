import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/dependencies.dart' as dep;
import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppConstants.STRIPE_PUBLISHABLE_KEY;
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartDataWhenAppStart();
    return ScreenUtilInit(
      child: GetBuilder<PopularProductController>(
        builder: (_) {
          return GetBuilder<RecommendedProductController>(
            builder: (_) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',

                // home: SignInPage(),
                // home: OrderSuccessPage(),
                initialRoute: RouteHelper.getSplashPage(),
                getPages: RouteHelper.routes,
                theme: ThemeData(
                  primaryColor: AppColors.primaryElement,
                  fontFamily: "Lato",
                )
              );
            },
          );
        },
      ),
    );
  }
}
