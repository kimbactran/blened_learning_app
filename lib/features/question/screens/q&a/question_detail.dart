

import 'package:blended_learning_appmb/common/widgets/answer/answer_card.dart';
import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/common/widgets/question/dislike_btn.dart';
import 'package:blended_learning_appmb/common/widgets/question/vote_widget.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card_question.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/edit_question.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/question_model.dart';
import '../answers/edit_answer_screen.dart';

// ignore: must_be_immutable
class QuestionDetailScreen extends StatelessWidget {
  const QuestionDetailScreen({
    super.key,
    required this.question,
    //  required this.questionId
  });
  // String questionId;
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    final answerController = Get.put(AnswerController());
    questionController.isDownVote.value = question.isDownVote!;
    questionController.isUpVote.value = question.isUpVote!;
    questionController.numDownVote.value = question.numDownVote!;
    questionController.numUpVote.value = question.numUpVote!;

    return Scaffold(
      appBar: const LAppBar(
        title: Text("Question Detail"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LUserCardQuestion(
                    user: question.user!,
                    time: question.createdAt!, postId: question.id!,
                    onActionDelete: () {
                      questionController.deleteQuestion(question.id!);
                      Get.back();
                    },
                    onActionEdit: () => Get.to(() => EditQuestionScreen(question: question)),
                  ),
              Html(
                data: question.content,
              ),
              // Text(question.content!),
              /*const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Image(
                image: AssetImage(LImages.classImage1),
              ),*/
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              Wrap(
                spacing: LSizes.defaultSpace,
                children:
                    question.tags!.map((tag) => LTagCard(tag: tag)).toList(),
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
               Obx(
                 () => VoteWidget(isUpVote: questionController.isUpVote.value,
                     isDownVote: questionController.isDownVote.value,
                     numUpVote: questionController.numUpVote.value,
                     numDownVote: questionController.numDownVote.value,
                     isUpVoteAction: () => questionController.likeQuestion(question),
                     isDownVoteAction: () => questionController.dislikeQuestion(question))

               ),

              const SizedBox(
                height: LSizes.spaceBtwItems / 2,
              ),
              const Divider(),

              Padding(
                padding: const EdgeInsets.all(LSizes.sm),
                child: Obx(
                  () => FutureBuilder(
                    key: Key(answerController.refreshData.value.toString()),
                    future: answerController.getCommentOfPost(question.id!, "", answerController.orderStatus.value.toString()),
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
                                    , child: Text('Hot', style: Theme.of(context).textTheme.labelMedium?.apply(color: answerController.orderStatus.value == 'HIGH_SCORES' ? LColors.error : LColors.black),), ),

                                    TextButton(onPressed: ()=> answerController.changeOrder('DESC'), child: Text("New", style: Theme.of(context).textTheme.labelMedium?.apply(color: answerController.orderStatus.value == 'DESC' ? LColors.error : LColors.black),),),

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

                                return LAnswerCard(answer: answers[index],
                                  questionId: question.id!,
                                  onActionDelete: () => answerController.deleteAnswer(answers[index].id!),
                                  onActionEdit: () => Get.to(() => EditAnswerScreen(answer: answers[index])),
                                );
                              }),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
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
                  controller: answerController.commentText,
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
                onPressed: () => answerController.addComment(
                    question.id!, question.classId??""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
