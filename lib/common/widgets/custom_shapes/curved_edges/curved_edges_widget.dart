import 'package:blended_learning_appmb/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class LCurvedEdgeWidget extends StatelessWidget {
  const LCurvedEdgeWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LCustomCurvedEdges(),
      child: child,
    );
  }
}
