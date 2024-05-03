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

class QuestionOfUser extends StatelessWidget {
  const QuestionOfUser({super.key});


  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    return Scaffold(
      appBar: LAppBar(
        title: Text("My Questions",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.md),
          child: Obx(
            () => FutureBuilder(

              future: questionController.getQuestionOfUser(),
              builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found

                final questions = snapshot.data!;
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${questions.length} questions'),
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
