import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuestionAction extends StatelessWidget {
  const QuestionAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Iconsax.message),
            SizedBox(
              width: LSizes.spaceBtwItems / 2,
            ),
            Text('5 câu trả lời')
          ],
        ),
        ElevatedButton(
          onPressed: () => Get.to(() => const QuestionDetailScreen()),
          child: const Text("Trả lời"),
        )
      ],
    );
  }
}
