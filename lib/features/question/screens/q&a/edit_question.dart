import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/tag_card/tag_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/class_controller.dart';
import '../../controllers/question_controller.dart';
import '../../controllers/tag_controller.dart';
import '../../models/class_model.dart';
import '../tag/tag.dart';

class EditQuestionScreen extends StatelessWidget {
  const EditQuestionScreen({super.key, required this.question});
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    final classController = ClassController.instance;
    final tagController = Get.put(TagController());
    return Scaffold(
      appBar: LAppBar(
        title: Text("Edit Question",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        actions: [
          OutlinedButton(
              onPressed: () => questionController
                  .editQuestion(questionController.classSelected.value.id.toString(), tagController.covertToListTag()),
              child: const Text("Add question"))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(LSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: questionController.title,
                  initialValue: question.title,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),

                /*const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                DropdownButtonFormField<ClassModel>(
                  decoration: const InputDecoration(labelText: "Class"),
                  items: classController.allClasses
                      .map((course) => DropdownMenuItem<ClassModel>(
                      value: course, child: Text(course.title ?? "")))
                      .toList(),
                  onChanged: (course) {
                    questionController.setClassSelected(course!);
                  },
                  value: classController.allClasses[0],)*/
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),

                Obx(
                        () =>
                       Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(
                              'Select Tag',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: LColors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            flex: 11,
                            child: Obx(
                                  () => Wrap(
                                spacing: LSizes.defaultSpace,
                                children: tagController.selectedTags
                                    .map((tag) => LTagCard(tag: tag, showCancelBtn: true, maxline: 1, onCancel: () => tagController.removeTagFromSelected(tag),))
                                    .toList(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Iconsax.arrow_right_34),
                            iconSize: 18,
                            onPressed: () => Get.to(() => TagScreen(
                              classId: questionController.classSelected.value.id!,
                            )),
                          ),
                        ],
                      )

                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                Text("Description", style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: LColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
                QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                    controller: questionController.quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Màu sắc của viền
                      width: 2.0, // Độ dày của viền
                    ),
                  ),
                  height: 200,
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: questionController.quillController,
                      readOnly: false,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('en'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
