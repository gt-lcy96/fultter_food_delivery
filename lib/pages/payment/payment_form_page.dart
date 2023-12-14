import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/showCustomSnackBar.dart';
import 'package:food_delivery/controllers/payment_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentForm extends StatelessWidget {
  PaymentForm({super.key});

  late Map<String, dynamic> paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15.h),
          ElevatedButton(
            onPressed: () {
              payment();
            },
            child: const Text("Pay"),
          ),
        ],
      ),
    );
  }

  Future<void> payment() async {
    try {
      Map<String, dynamic> body = {
        'amount': 500,
        'currency': 'SGD',
      };

      // var response = await http.post(
      //   Uri.parse('https://api.stripe.com/v1/payment_intents'),
      //   headers: {
      //     'Authorization': 'Bearer ${AppConstants.STRIPE_PUBLISHABLE_KEY}',
      //     'Content-type': 'application/x-www-form-urlencoded'
      //   },
      // );
      var response =
          await Get.find<PaymentController>().createTestPaymentSheet();

      // paymentIntent = json.decode(response.body);
    } catch (error) {
      throw Exception(error);
    }

    // Step 2 : Initialize payment sheet
    // print("paymentIntent:  ${paymentIntent}");

    if (Get.find<PaymentController>().isLoading == false &&
        Get.find<PaymentController>().clientSecret != null) {
      var client_secret = Get.find<PaymentController>().clientSecret;
      print("client_secret:  ${client_secret}");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  // paymentIntentClientSecret: paymentIntent!['client_secret'],
                  customFlow: false,
                  paymentIntentClientSecret: client_secret,
                  allowsDelayedPaymentMethods: false,
                  style: ThemeMode.light,
                  merchantDisplayName: 'lohcy'))
          .then((value) => {});

      // Step 3 :  Display payment sheet
      try {
        bool payment_isSuccess = false;
        await Stripe.instance.presentPaymentSheet().then((value) {
          // Success State
          payment_isSuccess = true;
          print("Payment success");
        });
      } catch (error) {
        throw Exception(error);
      }
    } else {
      showCustomSnackBar("fail to fetch client secret");
    }
  }
}
