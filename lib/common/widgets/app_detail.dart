import 'package:flutter/material.dart';
import 'package:food_delivery/common/values/colors.dart';

Widget IconStatusList(status, distance, time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      NamedIcon(Icons.circle_sharp, status, color: Colors.yellow),
      NamedIcon(Icons.location_on, distance),
      NamedIcon(Icons.access_time_rounded, time, color: Colors.red[200]),
    ],
  );
}

Widget RatingList() {
  return Row(
    children: List.generate(5, (index) {
      return const Icon(Icons.star, color: AppColors.primaryElement);
    }),
  );
}

Widget NamedIcon(icon, text, {color = AppColors.primaryElement}) {
  return Row(children: [
    Icon(
      icon,
      color: color,
    ),
    Text(text)
  ]);
}
