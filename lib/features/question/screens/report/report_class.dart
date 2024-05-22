import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/report_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/report/widgets/answer_report_card.dart';
import 'package:blended_learning_appmb/features/question/screens/report/widgets/interactive_report_card.dart';
import 'package:blended_learning_appmb/features/question/screens/report/widgets/question_report_card.dart';
import 'package:blended_learning_appmb/features/question/screens/report/widgets/tag_report_table.dart';
import 'package:blended_learning_appmb/features/question/screens/report/widgets/user_attribute_table.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/class_model.dart';

class ReportClassScreen extends StatelessWidget {
  const ReportClassScreen({super.key, required this.course});
  final ClassModel course;

  @override
  Widget build(BuildContext context) {
    final reportController = Get.put(ReportController());
    return  Scaffold(
      appBar: const LAppBar(title: Text("Report"), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.all(LSizes.sm),
              child: FutureBuilder(
                future: reportController.getReportOfClass(course),
                builder: (context, snapshot) {
                  final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                  if(widget != null) return widget;
                  // Data found
                  final report = snapshot.data;
                  return Column(
                    children: [
                      Center(
                        child: Wrap(
                          spacing: LSizes.spaceBtwItems,
                            runSpacing: LSizes.spaceBtwItems,
                            children: [
                            QuestionReportCard(numOfQuestion: report!.numQuestions!),
                            AnswerReportCard(numOfQuestion: report.numQuestions!, numOfAnswer: report.numAnswers!),
                            InteractiveReportCard(numLike: report.numLikes!, numDislike: report.numDislike!,)
                        ],),
                      ),
                      const SizedBox(height: LSizes.spaceBtwItems),
                      UserAttributeTable(users: report.userAttributes!,),
                      const SizedBox(height: LSizes.spaceBtwItems),
                      TagReportTable(tagReports: report.tagReports!)
                    ],
                  );
                }
              ),
          
            ),
      ),

      
    );
  }
}
