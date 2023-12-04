import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food_detail/PopularFoodDetail_page.dart';
import 'package:food_delivery/pages/food_detail/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cart = "/cart";
  static const String signIn = "/sign-in";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String fromPage) => '$popularFood?pageId=$pageId&fromPage=$fromPage';
  static String getRecommendedFood(int pageId, String fromPage) =>
      '$recommendedFood?pageId=$pageId&fromPage=$fromPage';
  static String getCart() => '$cart';
  static String getSignIn() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: signIn, page: () => const SignInPage(), transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var fromPage = Get.parameters['fromPage'];
          return PopularFoodDetail(pageId: int.parse(pageId!), fromPage: fromPage!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var fromPage = Get.parameters['fromPage'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), fromPage: fromPage!);
        },
        transition: Transition.fadeIn),
    GetPage(name: cart, page: () => const CartPage()),
  ];
}
