import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuestionAction extends StatelessWidget {
  const QuestionAction({
    super.key,
    required this.question,
  });
  final QuestionModel question;


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
            Text('5 answers')
          ],
        ),
        ElevatedButton(
          onPressed: () => Get.to(() => QuestionDetailScreen(
                question: question,
              )),
          child: const Text("Reply"),
        )
      ],
    );
  }
}
