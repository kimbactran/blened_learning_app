import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/question/question_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/class_model.dart';

class QuestionInClassScreen extends StatelessWidget {
  const QuestionInClassScreen({super.key, required this.course});

  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    final classController = ClassController.instance;
    final questionController = Get.put(QuestionController());
    return Scaffold(
      appBar: LAppBar(
        title: Text("Question in Classes",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.md),
          child: Obx(
            () => FutureBuilder(
              key: Key(classController.refreshData.value.toString()),
              future: questionController.getQuestionInClassWithSort(course.id!, classController.orderStatus.value.toString()),
              builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found

                final questions = snapshot.data!;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${course.numberQuestion} questions'),
                        Obx(
                              () => Row(
                            children: [
                              TextButton(onPressed: () => classController.changeOrder('HIGH_SCORES')
                                , child: Text('Hot', style: Theme.of(context).textTheme.labelMedium?.apply(color: classController.orderStatus.value == 'HIGH_SCORES' ? LColors.error : LColors.grey),), ),

                              TextButton(onPressed: ()=> classController.changeOrder('DESC'), child: Text("New", style: Theme.of(context).textTheme.labelMedium?.apply(color: classController.orderStatus.value == 'DESC' ? LColors.error : LColors.grey),),),

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
                        itemCount: questions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return LQuestionCard(question: questions[index],);

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
