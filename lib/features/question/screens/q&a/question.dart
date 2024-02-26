import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/icons/circular_icon.dart';
import 'package:blended_learning_appmb/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:blended_learning_appmb/common/widgets/question/question_card.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/features/question/controllers/post_contoller.dart';
import 'package:blended_learning_appmb/features/question/screens/classes/classes.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/add_new_question.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());

    return Scaffold(
      appBar: LAppBar(
        title: Text('Q & A', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          LCircularIcon(
            icon: Iconsax.notification,
            onPressed: () {},
          ),
          LCircularIcon(
            icon: Iconsax.filter,
            onPressed: () {},
          ),
          LCircularIcon(
            icon: Iconsax.search_normal,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Class
        child: Padding(
          padding: const EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            children: [
              LSectionHeading(
                title: "My Classes",
                showActionButton: true,
                onPressed: () => Get.to(() => const ClassesScreen()),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, item) {
                      return const LVerticalImageText(
                          image: LImages.classImage,
                          title: 'INT3848 - Classroom Name');
                    }),
              ),
              const Divider(),
              Obx(
                () => ListView.builder(
                  itemCount: postController.questions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<String> reversedQuestions =
                        List.from(postController.questions.reversed);
                    return Column(
                      children: [
                        LQuestionCard(
                          questionText: reversedQuestions[index],
                          tags: const [
                            "UET",
                            "Xác suất thống kê",
                            "Biến cố của xác suất"
                          ],
                        ),
                        const SizedBox(
                          height: LSizes.spaceBtwItems,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: LSizes.spaceBtwSections,
              ),
              const LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              const LQuestionCard(
                questionText:
                    "According to the table manners in England, we have to use a knife and folk at dinner",
                tags: ["UET", "Xác suất thống kê", "Biến cố của xác suất"],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Add new Question",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: LColors.white),
        ),
        onPressed: () => Get.to(() => const AddNewQuestionScreen()),
        icon: const Icon(Iconsax.message_add, color: Colors.white),
        backgroundColor: LColors.primary1,
      ),
    );
  }
}
