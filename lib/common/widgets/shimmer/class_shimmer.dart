import 'package:blended_learning_appmb/common/widgets/shimmer/shimmer.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LCategoryShimmer extends StatelessWidget {
  const LCategoryShimmer({super.key, this.itemCount = 6});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                LShimmerEffect(
                  width: 55,
                  height: 55,
                  radius: 55,
                ),
                SizedBox(
                  height: LSizes.spaceBtwItems / 2,
                ),

                // Text
                LShimmerEffect(width: 55, height: 8),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
                width: LSizes.spaceBtwItems,
              ),
          itemCount: itemCount),
    );
  }
}
