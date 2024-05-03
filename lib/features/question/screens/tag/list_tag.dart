import 'dart:async';

import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/features/question/controllers/tag_controller.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/question_controller.dart';
import '../q&a/widgets/list_question.dart';

class ListTag extends StatelessWidget {
  const ListTag({super.key, required this.classId});

  final String classId;
  @override
  Widget build(BuildContext context) {
    final tagController = TagController.instance;
    final questionController = QuestionController.instance;

    return Scaffold(
      appBar: LAppBar(
        title: Text('All tag of class',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(children: [

            FutureBuilder(
              key: Key(tagController.refreshData.value.toString()),
              future: tagController.getAllTags(classId),
              builder: (context, snapshot) {
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found

                final tags = snapshot.data;
                final syllabusTags =  tags!.where((tag) => tag.type == "SYLLABUS").toList();
                final freeTags =  tags.where((tag) => tag.type == "FREE").toList();
                return Column(
                  children: [
                    const LSectionHeading(
                      title: "Syllabus Tags",
                      showActionButton: false,
                    ),
                     ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        if (syllabusTags.isEmpty) {
                          return const Center(child: Text('No Tag'));
                        }
                        final tag = syllabusTags[index];
                        return LTagCard(
                            tag: tag,
                                onTap: () => Get.to(() =>  ListQuestion(title: "Questions of Tag",getData: questionController.getQuestionOfTag(tag),)),
                              );

                      },
                      itemCount: syllabusTags.length,
                    ),
                    const SizedBox(
                      height: LSizes.spaceBtwInputFields,
                    ),
                    const Divider(),

                    const LSectionHeading(
                      title: "Free Tags",
                      showActionButton: false,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        if (freeTags.isEmpty) {
                          return const Center(child: Text('No Tag'));
                        }
                        final tag = freeTags[index];
                        return LTagCard(
                            tag: tag,
                            onTap: () => Get.to(() =>  ListQuestion(title: 'Questions Of Tag',getData: questionController.getQuestionOfTag(tag),)),


                        );
                      },
                      itemCount: freeTags.length,
                    )
                  ],
                );
              }
            ),

          ]),
        ),
      ),
    );
  }
}
