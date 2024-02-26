import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/features/question/controllers/post_contoller.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuestionDetailScreen extends StatelessWidget {
  const QuestionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();

    return Scaffold(
      appBar: const LAppBar(
        title: Center(child: LUserCard()),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("According....."),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Image(
                image: AssetImage(LImages.classImage1),
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const Wrap(spacing: LSizes.defaultSpace, children: [
                LTagCard(title: "UET"),
                LTagCard(title: "Xác suất thống kê"),
              ]),
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
                  itemCount: postController.comments.length,
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
                          Text(postController.comments[index]),
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
                        controller: postController.commentText,
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
                      onPressed: postController.addComment,
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
