import 'package:blended_learning_appmb/common/widgets/image/rounded_image.dart';
import 'package:blended_learning_appmb/common/widgets/question/question_action.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card_question.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../features/question/controllers/question_controller.dart';


class LQuestionCard extends StatelessWidget {
  const LQuestionCard({super.key, required this.question});

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    return GestureDetector(
      onTap: () => Get.to(() => QuestionDetailScreen(
            question: question,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LUserCardQuestion(
            user: question.user!,
            time: question.createdAt!, postId: question.id!,
            onActionDelete: () => questionController.deleteQuestion(question.id!),
          ),
          Html(data: question.title!),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
          /*const LRoundedImage(imageUrl: LImages.classImage1),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),*/
          Wrap(
            spacing: LSizes.defaultSpace,
            children: question.tags!.map((tag) => LTagCard(tag: tag)).toList(),
          ),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
          QuestionAction(
            question: question,
          ),
          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
