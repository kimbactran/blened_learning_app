import 'package:blended_learning_appmb/common/widgets/question/vote_question_widget.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        VoteQuestionWidget(question: question),
          
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
