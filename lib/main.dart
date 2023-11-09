import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/pages/food_detail/PopularFoodDetail_page.dart';
import 'package:food_delivery/pages/food_detail/recommended_food_detail.dart';
import 'package:food_delivery/pages/main_food/main_food_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
    
    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const RecommendedFoodDetail(),
          
        ),
      );
    }
}
 
