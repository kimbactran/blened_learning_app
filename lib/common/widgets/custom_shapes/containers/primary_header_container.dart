import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LPrimaryHeaderContainer extends StatelessWidget {
  const LPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LCurvedEdgeWidget(
      child: Container(
        color: LColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: LCircularContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  padding: 0,
                  backgroundColor: LColors.textWhite.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: LCircularContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  padding: 0,
                  backgroundColor: LColors.textWhite.withOpacity(0.1)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
