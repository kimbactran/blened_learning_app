import 'package:blended_learning_appmb/common/widgets/question/dislike_btn.dart';
import 'package:blended_learning_appmb/common/widgets/question/like_btn.dart';
import 'package:blended_learning_appmb/common/widgets/question/vote_widget.dart';
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
        VoteWidget(isUpVote: question.isUpVote!,
            isDownVote: question.isDownVote!,
            numUpVote: question.numUpVote!,
            numDownVote: question.numDownVote!),
          
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
