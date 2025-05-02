import 'package:eco_rider_user/Helper/Colors.dart';
import 'package:flutter/material.dart';

const spacing_middle = 10.0;

BoxDecoration boxDecoration(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: AppColors.colorView.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1)
          ]
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}
