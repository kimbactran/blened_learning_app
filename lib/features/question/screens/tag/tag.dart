import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/features/question/controllers/tag_controller.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({super.key, required this.classId});

  final String classId;
  @override
  Widget build(BuildContext context) {
    final tagController = TagController.instance;

    return Scaffold(
      appBar: LAppBar(
        title: Text('Select Tag',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: tagController.tag,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                ),
                const SizedBox(
                  width: LSizes.sm,
                ),
                ElevatedButton(
                    onPressed: () => tagController.addNewTag(classId),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('Add Tag'),
                    ))
              ],
            ),
            const SizedBox(
              height: LSizes.spaceBtwInputFields,
            ),
            const Divider(),
            FutureBuilder(
                key: Key(tagController.refreshData.value.toString()),
                future: tagController.getAllTags(classId),
                builder: (context, snapshot) {
                  final widget =
                      LCloudHelperFunctions.checkSingleRecordState(snapshot);
                  if (widget != null) return widget;
                  // Data found

                  final tags = snapshot.data;
                  final syllabusTags =
                      tags!.where((tag) => tag.type == "SYLLABUS").toList();
                  final freeTags =
                      tags.where((tag) => tag.type == "FREE").toList();
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
                          return Obx(
                            () => LTagCard(
                              tag: tag,
                              onTap: () => tagController.onSelectedTag(tag),
                              color: tagController.selectedTags.contains(tag)
                                  ? LColors.secondary
                                  : LColors.primary1,
                            ),
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
                          return Obx(() {
                            if (tagController.selectedTags.contains(tag)) {
                              return LTagCard(
                                  tag: tag,
                                  onTap: () => tagController.onSelectedTag(tag),
                                  color: LColors.secondary);
                            }
                            return LTagCard(
                              tag: tag,
                              onTap: () => tagController.onSelectedTag(tag),
                              color: LColors.primary1,
                            );
                          });
                        },
                        itemCount: freeTags.length,
                      )
                    ],
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
