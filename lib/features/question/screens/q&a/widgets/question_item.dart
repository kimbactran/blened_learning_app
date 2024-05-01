import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/screens/classes/question_in_class.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LQuestionItem extends StatelessWidget {
  const LQuestionItem({
    super.key,
    required this.showBorder, required this.course,
  });

  final bool showBorder;
  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() =>  QuestionInClassScreen(course: course,)),
      child: Padding(
        padding: const EdgeInsets.all(LSizes.sm),
        child: LRoundedContainer(
          padding: const EdgeInsets.all(LSizes.sm),
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          child: const Padding(
            padding: EdgeInsets.all(LSizes.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("All Question"), Icon(Iconsax.arrow_right)],
            ),
          ),
        ),
      ),
    );
  }
}
