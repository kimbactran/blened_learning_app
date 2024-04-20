import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/answer/answer_card.dart';
import '../../../../common/widgets/question/vote_widget.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({super.key,  required this.answer, required this.questionId});

  final AnswerModel answer;
  final String questionId;
  @override
  Widget build(BuildContext context) {
    final answerController = AnswerController.instance;
    answerController.isDownVote.value = answer.isDownVote!;
    answerController.isUpVote.value = answer.isUpVote!;
    answerController.numDownVote.value = answer.numDownVote!;
    answerController.numUpVote.value = answer.numUpVote!;
    return Scaffold(
      appBar: const LAppBar(showBackArrow: true, title: Text("Answer Detail"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            children: [
              const SizedBox(
                height: LSizes.spaceBtwItems / 2,
              ),
              LAnswerCard(answer: answer, isShowVoteAction: false,
                questionId: questionId, showNumOfAnswer: false, onActionDelete: () {
                answerController.deleteAnswer(answer.id!);
                Get.back();
              },
              ),
          // Action Vote
              Obx(
                      () => VoteWidget(isUpVote: answerController.isUpVote.value,
                      isDownVote: answerController.isDownVote.value,
                      numUpVote: answerController.numUpVote.value,
                      numDownVote: answerController.numDownVote.value,
                      isUpVoteAction: () => answerController.likeAnswer(answer),
                      isDownVoteAction: () => answerController.dislikeAnswer(answer))

              ),

          Padding(
            padding: const EdgeInsets.all(LSizes.sm),
            child: Obx(
                  () => FutureBuilder(
                key: Key(answerController.refreshDataOnAns.value.toString()),
                future: answerController.getAnswerOfAnswer("", questionId ,answer.id!, answerController.orderStatus.value.toString()),
                builder: (context, snapshot) {
                  final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                  if(widget != null) return widget;
                  // Data found

                  final answers = snapshot.data!;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${answers.length} answers'),
                          Obx(
                                () => Row(
                              children: [
                                TextButton(onPressed: () => answerController.changeOrder('HIGH_SCORES')
                                  , child: Text('Hot', style: Theme.of(context).textTheme.labelMedium?.apply(color: answerController.orderStatus.value == 'HIGH_SCORES' ? LColors.error : LColors.grey),), ),

                                TextButton(onPressed: ()=> answerController.changeOrder('DESC'), child: Text("New", style: Theme.of(context).textTheme.labelMedium?.apply(color: answerController.orderStatus.value == 'DESC' ? LColors.error : LColors.grey),),),

                              ],
                            ),
                          ),
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
                            return LAnswerCard(answer: answers[index], questionId: questionId,showNumOfAnswer: false, onActionDelete: () => answerController.deleteAnswer(answer.id!),);
                          }),
                    ],
                  );
                },
              ),
            ),
          )],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  controller: answerController.commentSubText,
                  decoration: const InputDecoration(
                    hintText: 'Enter your comment',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Iconsax.send1,
                  color: LColors.primary1,
                ),
                onPressed: () => answerController.addAnswerOfAnswer(
                    questionId, 'c690d6d8-f429-47d2-8bfa-7fe9fb53527e', answer.id ?? "")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
