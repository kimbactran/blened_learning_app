import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LCircularContainer extends StatelessWidget {
  const LCircularContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = 400,
      this.padding = 0,
      this.child,
      this.backgroundColor = LColors.white,
      this.margin});

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
