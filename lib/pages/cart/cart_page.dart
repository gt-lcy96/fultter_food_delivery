import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/values/enums.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/common/widgets/no_data_page.dart';
import 'package:food_delivery/common/widgets/showCustomSnackBar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/payment_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/pages/food_detail/widgets/PopularFoodDetail_widget.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 60.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                icon: Icons.arrow_back_ios,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryElement,
                iconSize: 20,
              ),
              SizedBox(width: 100.w),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.initial);
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.primaryElement,
                  iconSize: 20,
                ),
              ),
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryElement,
                iconSize: 20,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getItems.length > 0
              ? Positioned(
                  top: 100.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 0,
                  child: Container(
                      margin: EdgeInsets.only(top: 15.h),
                      // color: Colors.red,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                // itemCount: 10,
                                // separatorBuilder: (context, index) => SizedBox(
                                //       height: 10.w,
                                //     ),
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: 100.h,
                                    width: double.maxFinite,
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product);
                                            if (popularIndex >= 0) {
                                              //if found
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      RouteHelper.cart));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(
                                                      _cartList[index].product);
                                              if (recommendedIndex < 0) {
                                                //cant found any
                                                Get.snackbar(
                                                  "History product",
                                                  "Product review is not available for history products",
                                                  backgroundColor:
                                                      AppColors.primaryElement,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed(//found recommended
                                                    RouteHelper
                                                        .getRecommendedFood(
                                                            recommendedIndex,
                                                            RouteHelper.cart));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 100.w,
                                            height: 100.h,
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          _cartList[index]
                                                              .img!),
                                                  // "assets/images/chinese_food_1.jpg"),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20.w),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                            child: Container(
                                                height: 100.h,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    bigText(
                                                        _cartList[index].name!,
                                                        color: Colors.black),
                                                    smallText("Spicy"),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        bigText(
                                                          "\$ ${_cartList[index].price}",
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        counterWidget(
                                                            cartController,
                                                            index),
                                                      ],
                                                    )
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      )),
                )
              : NoDataPage(text: "Your cart is empty");
        }),
      ]),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: 100.h,
            padding: EdgeInsets.only(
                top: 15.h, bottom: 15.h, left: 20.w, right: 20.w),
            decoration: BoxDecoration(
                color: AppColors.primarySecondaryElementText.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w * 2),
                  topRight: Radius.circular(20.w * 2),
                )),
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      priceValue(cartController),
                      checkOutButton(cartController),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

Widget checkOutButton(CartController cartController) {
  return GestureDetector(
    onTap: () async {
      if (Get.find<AuthController>().userLoggedIn()) {
        await Get.find<LocationController>().getAddressList();
        if (Get.find<LocationController>().addressList.isNotEmpty) {
          // await Get.find<UserController>().getUserInfo();
          // new
          Get.find<LocationController>().getUserAddress();
          if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
              "") {
            Get.find<LocationController>().saveUserAddress(
                Get.find<LocationController>().addressList.last);
          }

          make_payment(cartController.getItems);
        } else if (Get.find<LocationController>().addressList.isEmpty) {
          Get.toNamed(RouteHelper.getAddressPage());
        } 
      } else {
        Get.toNamed(RouteHelper.getSignIn());
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: AppColors.primaryElement,
      ),
      child: bigText("Checkout",
          color: AppColors.primaryBackground, fontSize: 16.sp),
    ),
  );
}

Widget priceValue(CartController cartController) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w), color: Colors.white),
    child: bigText("\$ ${cartController.totalAmount}"),
  );
}

Future<void> make_payment(List<CartModel> orderItems) async {
  try {
    // Map<String, dynamic> body = {
    //   'amount': 500,
    //   'currency': 'SGD',
    // };

    // var response = await http.post(
    //   Uri.parse('https://api.stripe.com/v1/payment_intents'),
    //   headers: {
    //     'Authorization': 'Bearer ${AppConstants.STRIPE_PUBLISHABLE_KEY}',
    //     'Content-type': 'application/x-www-form-urlencoded'
    //   },
    // );

    var response =
        await Get.find<PaymentController>().createTestPaymentSheet(orderItems);

    // paymentIntent = json.decode(response.body);
  } catch (error) {
    throw Exception(error);
  }

  // Step 2 : Initialize payment sheet
  // print("paymentIntent:  ${paymentIntent}");

  if (Get.find<PaymentController>().isLoading == false &&
      Get.find<PaymentController>().paymentIntent != null) {
    var paymentIntent = Get.find<PaymentController>().paymentIntent;
    // print("client_secret:  ${client_secret}");
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                // paymentIntentClientSecret: paymentIntent!['client_secret'],
                customFlow: false,
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                allowsDelayedPaymentMethods: false,
                style: ThemeMode.light,
                merchantDisplayName: 'lohcy'))
        .then((value) => {});

    // Step 3 :  Display payment sheet
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        Get.find<PaymentController>().updatePaymentStatus(Status.COMPLETED.name, client_secret!);
        print("Payment success");
      });

      // await Stripe.instance.confirmPaymentSheetPayment();
    } on Exception catch (e) {
      if (e is StripeException) {
        Get.find<PaymentController>().updatePaymentStatus(Status.CANCELED.name, paymentIntent['client_secret']);
        showCustomSnackBar('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Get.find<PaymentController>().updatePaymentStatus(Status.REJECTED.name, paymentIntent['client_secret']!);
        showCustomSnackBar('Unforeseen error: $e');
      }
    }
  } else {
    showCustomSnackBar("fail to fetch client secret");
  }
}

Widget counterWidget(CartController cartController, int index) {
  var cartItem = cartController.getItems[index];
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w), color: Colors.white),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            // popularProudct.setQuantity(false);
            cartController.addItem(cartItem.product!, -1);
          },
          child: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5.h,
        ),
        bigText(cartItem.quantity.toString()),
        // bigText(popularProudct.inCartItems.toString()),
        SizedBox(
          width: 5.h,
        ),
        GestureDetector(
          onTap: () {
            // popularProudct.setQuantity(true);
            cartController.addItem(cartItem.product!, 1);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ]));
}
