import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card_question.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_contoller.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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

    return Scaffold(
      appBar: LAppBar(
        title: Center(
            child: LUserCardQuestion(
          user: question.user!,
          time: question.createdAt!,
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
                children: question.tags!
                    .map((tag) => LTagCard(title: tag.tag!))
                    .toList(),
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.like),
                        Text("2"),
                        SizedBox(
                          width: LSizes.spaceBtwItems,
                        ),
                        Icon(Iconsax.dislike),
                        Text("0")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
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
              const SizedBox(
                height: LSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0 câu trả lời'),
                  Row(
                    children: [
                      Text("Hot"),
                      SizedBox(
                        width: LSizes.sm,
                      ),
                      Text("Mới"),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems / 2,
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questionController.comments.length,
                  itemBuilder: (context, index) {
                    return LRoundedContainer(
                      showBorder: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LUserCard(),
                          const SizedBox(
                            height: LSizes.spaceBtwItems / 2,
                          ),
                          Text(questionController.comments[index]),
                          const SizedBox(
                            height: LSizes.spaceBtwItems / 2,
                          ),
                          const Row(
                            children: [
                              Icon(Iconsax.like),
                              Text("2"),
                              SizedBox(
                                width: LSizes.spaceBtwItems,
                              ),
                              Icon(Iconsax.dislike),
                              Text("0"),
                              SizedBox(
                                width: LSizes.spaceBtwItems,
                              ),
                              Icon(Iconsax.star),
                              Text('0,0/5'),
                              Text('(0 đánh giá)'),
                            ],
                          ),
                          const SizedBox(
                            height: LSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Iconsax.arrow_down_2),
                                  Text("Xem 0 phản hồi"),
                                ],
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: const Text("Phản hồi"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: LSizes.spaceBtwItems / 2,
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: questionController.commentText,
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
                      onPressed: questionController.addComment,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
