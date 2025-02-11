import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/color_class.dart';

class AppText {
  static const bold = TextStyle(
    fontFamily: "EuclidCircularA",
    fontWeight: FontWeight.bold,
  );
  static const semiBold = TextStyle(
    fontFamily: "EuclidCircularA",
    fontWeight: FontWeight.w500,
  );
  static const regular = TextStyle(
    fontFamily: "EuclidCircularA",
    fontWeight: FontWeight.normal,
  );
  static const regularBlack = TextStyle(
    fontFamily: "EuclidCircularA",
    fontWeight: FontWeight.normal,
    color: ColorClass.appBlack,
  );
}
