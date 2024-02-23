import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: LColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: LColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
