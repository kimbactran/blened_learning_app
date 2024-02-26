import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LTagCard extends StatelessWidget {
  const LTagCard({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: LRoundedContainer(
        backgroundColor: LColors.secondary,
        padding: const EdgeInsets.all(4),
        radius: LSizes.sm,
        margin: const EdgeInsets.all(4),
        child: Text(
          "#" + title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
