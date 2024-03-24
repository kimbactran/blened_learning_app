import 'package:blended_learning_appmb/common/layouts/grid_layout.dart';
import 'package:blended_learning_appmb/common/widgets/shimmer/shimmer.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LVerticalProductShimmer extends StatelessWidget {
  final int itemCount;

  const LVerticalProductShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return LGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  LShimmerEffect(width: 180, height: 180),
                  SizedBox(
                    height: LSizes.spaceBtwItems,
                  ),

                  // Text
                  LShimmerEffect(width: 160, height: 15),
                  SizedBox(
                    height: LSizes.spaceBtwItems / 2,
                  ),
                  LShimmerEffect(width: 110, height: 15)
                ],
              ),
            ));
  }
}
