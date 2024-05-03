import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InteractiveReportCard extends StatelessWidget {
  const InteractiveReportCard({super.key, required this.numLike, required this.numDislike});

  final int numLike;
  final int numDislike;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(LSizes.md),
      decoration: const BoxDecoration(
        color: LColors.primary1,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.messages_3),
            const SizedBox(height: LSizes.sm,),
            const Text('Total Interactive'),
            const SizedBox(height: LSizes.sm,),
            Row(
              children: [
                const Icon(Iconsax.like),
                SizedBox(width: LSizes.spaceBtwItems,),
                Text('${numLike}', style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            const SizedBox(height: LSizes.sm,),

            Row(
              children: [
                const Icon(Iconsax.dislike),
                SizedBox(width: LSizes.spaceBtwItems,),
                Text('${numDislike}', style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
