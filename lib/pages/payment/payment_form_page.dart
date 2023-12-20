import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/showCustomSnackBar.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/payment_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
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
              // payment();
            },
            child: const Text("Pay"),
          ),
        ],
      ),
    );
  }

  

}