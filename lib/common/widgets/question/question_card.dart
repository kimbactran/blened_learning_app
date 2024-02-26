import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/common/widgets/image/rounded_image.dart';
import 'package:blended_learning_appmb/common/widgets/question/question_action.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LQuestionCard extends StatelessWidget {
  const LQuestionCard(
      {super.key, required this.questionText, required this.tags});

  final String questionText;
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const QuestionDetailScreen()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LUserCard(),
          Text(questionText),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
          const LRoundedImage(imageUrl: LImages.classImage1),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
          Wrap(
            spacing: LSizes.defaultSpace,
            children: tags.map((tag) => LTagCard(title: tag)).toList(),
          ),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
          const QuestionAction()
        ],
      ),
    );
  }
}
