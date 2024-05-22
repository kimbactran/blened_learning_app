import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/icons/circular_icon.dart';
import 'package:blended_learning_appmb/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:blended_learning_appmb/common/widgets/question/question_card.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/classes/classes.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/add_new_question.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/search_question.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController =     Get.put(QuestionController());
    final classController = ClassController.instance;

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
            onPressed: () => Get.to(() => const SearchQuestionScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Class
        child: Padding(
          padding: const EdgeInsets.all(LSizes.md),
          child: Column(
            children: [
              LSectionHeading(
                title: "My Classes",
                showActionButton: true,
                onPressed: () => Get.to(() => const ClassesScreen(showBackArrow: true,)),
              ),
              const SizedBox(height: LSizes.spaceBtwInputFields,),
              FutureBuilder(future: classController.getAllClasses(), builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found
                final courses = snapshot.data;
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: classController.allClasses.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return LVerticalImageText(
                            image: LImages.classImage,
                            title: classController.allClasses[index].title!);
                      }),
                );
              }),
              const SizedBox(height: LSizes.spaceBtwInputFields,),

              const Divider(),
              const SizedBox(
                height: LSizes.spaceBtwItems,
              ),
              Obx(
                () => FutureBuilder(
                  key: Key(questionController.refreshData.value.toString()),
                  future: questionController.getQuestionByUser(),
                  builder: (context, snapshot){
                    final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                    if(widget != null) return widget;
                    // Data found

                    final questions = snapshot.data;
                    return ListView.builder(
                      itemCount: questions?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                          return LQuestionCard(question: questions![index],);

                      },
                    );
                  },

                ),
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
