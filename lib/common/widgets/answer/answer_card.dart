import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card_question.dart';
import 'package:blended_learning_appmb/features/question/controllers/answer_controller.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/features/question/screens/answers/answer_area.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question.dart';
import 'package:blended_learning_appmb/utils/constants/enums.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_html/flutter_html.dart';

import '../custom_shapes/containers/rounded_container.dart';

class LAnswerCard extends StatelessWidget {
  const LAnswerCard({
    super.key,
    required this.answer, required this.questionId, this.showNumOfAnswer = true, this.onActionDelete,
  });

  final AnswerModel answer;
  final String questionId;
  final bool showNumOfAnswer;
  final Function()? onActionDelete;

  @override
  Widget build(BuildContext context) {
    final answerController = AnswerController.instance;
    int? num = 0;


    return GestureDetector(
      onTap: () => Get.to(() => AnswerScreen(answer: answer, questionId: questionId)),
      child: LRoundedContainer(
        showBorder: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LUserCardQuestion(
              user: answer.user!,
              time: answer.createdAt!, postId: answer.id!,
              onActionDelete: () => onActionDelete?.call()
            ),

            Html(data: answer.content!),
            const SizedBox(
              height: LSizes.spaceBtwItems / 2,
            ),
            // Action qu
            Row(
              children: [
                const Icon(Iconsax.like),
                Text(answer.numUpVote.toString()),
                const SizedBox(
                  width: LSizes.spaceBtwItems,
                ),
                const Icon(Iconsax.dislike),
                Text(answer.numDownVote.toString()),
                const SizedBox(
                  width: LSizes.spaceBtwItems,
                ),
                const Icon(Iconsax.star),
                const Text('0,0/5'),
                const Text('(0 đánh giá)'),
              ],
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems / 2,
            ),

            if(showNumOfAnswer)
            FutureBuilder(
              future: answerController.getAnswerOfAnswer("", questionId, answer.id!, answerController.orderStatus.value.toString()),
              builder: (context, snapshot) {

                if(snapshot.hasData) {
                  final answers = snapshot.data;
                   num = answers?.length;
                  return Row(
                    children: [
                      Icon(Iconsax.arrow_down_2),
                      Text("Show $num answer"),
                    ],
                  );
                }else {
                  return Container(); // Trả về một widget rỗng khi không có dữ liệu
                }



              }
            ),


            const SizedBox(
              height: LSizes.spaceBtwItems / 2,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}