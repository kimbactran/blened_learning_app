import 'package:blended_learning_appmb/common/widgets/answer/answer_card.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context) {
    final answerController = Get.put(AnswerController());
    return Obx(
      () => FutureBuilder(
        key: Key(answerController.refreshData.value.toString()),
        future: answerController.getCommentOfPost('', questionId, "HIGH_SCORES"),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(
              child: Text('No answer found!'),
            );
          final answers = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: answers.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                //return LAnswerCard(answer: answers[index]);
              });
        },
      ),
    );
  }
}
