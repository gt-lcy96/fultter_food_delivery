import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({super.key, required this.text,
    this.imgPath="assets/images/empty_cart.png"
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Image.asset(
        imgPath,
        height: mediaSize.height * 0.22,
        width: mediaSize.width * 0.22,
      ),
      SizedBox(height: mediaSize.height * 0.03),
      Text(
        text,
        style: TextStyle(
          fontSize: mediaSize.height * 0.0175,
          color: Theme.of(context).disabledColor,
        ),
        textAlign: TextAlign.center,
      )
    ],);
  }
}