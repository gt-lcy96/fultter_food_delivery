import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food_detail/PopularFoodDetail_page.dart';
import 'package:food_delivery/pages/food_detail/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/dependencies.dart' as dep;

// import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetBuilder<PopularProductController>(
        builder: (_) {
          return GetBuilder<RecommendedProductController>(
            builder: (_) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',

                // home: SplashScreen(),
                // home: const MainFoodPage(),
                initialRoute: RouteHelper.getSplashPage(),
                getPages: RouteHelper.routes,
              );
            },
          );
        },
      ),
    );
  }
}
