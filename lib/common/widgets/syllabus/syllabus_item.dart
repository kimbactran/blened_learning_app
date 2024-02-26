import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LSyllabusItem extends StatelessWidget {
  const LSyllabusItem(
      {super.key, required this.title, required this.countQuestion});

  final String title;
  final String countQuestion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Container(child: Text(title))),
        LRoundedContainer(
          backgroundColor: LColors.secondary,
          padding: const EdgeInsets.all(LSizes.sm),
          child: Text(countQuestion),
        )
      ],
    );
  }
}
