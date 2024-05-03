import 'package:blended_learning_appmb/common/widgets/answer/answer_card.dart';
import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/answers/edit_answer_screen.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/question_model.dart';

class AnswerOfUserScreen extends StatelessWidget {
  const AnswerOfUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    final answerController = Get.put(AnswerController());
    return Scaffold(appBar: const LAppBar(title: Text("My answer"), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.md),
          child: Obx(
                () => FutureBuilder(

                future: questionController.getAnswerOfUser(),
                builder: (context, snapshot) {
                  final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                  if(widget != null) return widget;
                  // Data found

                  final answers = snapshot.data!;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${answers.length} answers'),
                        ],
                      ),
                      const SizedBox(
                        height: LSizes.spaceBtwItems / 2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: answers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                LAnswerCard(answer: answers[index],
                                  questionId: answers[index].postId!,
                                  onActionDelete: () => answerController.deleteAnswer(answers[index].id!),
                                  onActionEdit: () => Get.to(() => EditAnswerScreen(answer: answers[index])),
                                ),
                                const SizedBox(height: LSizes.spaceBtwItems,),
                                ]
                            );

                          }),
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
