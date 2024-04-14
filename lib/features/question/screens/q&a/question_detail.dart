import 'dart:ffi';

import 'package:blended_learning_appmb/common/widgets/answer/answer_card.dart';
import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card_question.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_contoller.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/screens/answers/answer_area.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/enums.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

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

    return Scaffold(
      appBar: LAppBar(
        title: Center(
            child: LUserCardQuestion(
          user: question.user!,
          time: question.createdAt!, postId: question.id!,
              onActionDelete: () {
            questionController.deleteQuestion(question.id!);
            Get.back();
              },
        )),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Html(
                data: question.content,
              ),
              // Text(question.content!),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Image(
                image: AssetImage(LImages.classImage1),
              ),
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
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.like),
                            onPressed: () => questionController.likeQuestion(question),
                            color: questionController.isUpVote.value
                                ? Colors.red
                                : Colors.grey,
                          ),
                          Text(question.numDownVote.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: LSizes.spaceBtwItems,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.dislike),
                            onPressed: () => questionController.dislikeQuestion(question),
                                
                            color: questionController.isDownVote.value
                                ? Colors.red
                                : Colors.grey,
                          ),
                          Text(question.numDownVote.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: LSizes.spaceBtwItems,
                    ),
                    const Flexible(
                      flex: 1,
                      child: Wrap(
                        children: [
                          Icon(Iconsax.star),
                          SizedBox(
                            width: LSizes.spaceBtwItems,
                          ),
                          Text('0,0/5'),
                          SizedBox(
                            width: LSizes.spaceBtwItems,
                          ),
                          Text(
                            '(0 đánh giá)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    future: answerController.getCommentOfPost('', question.id!, answerController.orderStatus.value.toString()),
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

                                return LAnswerCard(answer: answers[index], questionId: question.id!, onActionDelete: () => answerController.deleteAnswer(answers[index].id!),);
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
                    question.id!, 'c690d6d8-f429-47d2-8bfa-7fe9fb53527e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
