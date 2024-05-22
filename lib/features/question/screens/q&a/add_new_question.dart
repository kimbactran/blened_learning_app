import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/tag_card/tag_card.dart';
import 'package:blended_learning_appmb/features/question/controllers/add_question_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/tag_controller.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/widgets/add_image.dart';
import 'package:blended_learning_appmb/features/question/screens/tag/tag.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddNewQuestionScreen extends StatelessWidget {
  const AddNewQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tagController = TagController.instance;
    final addQuestionController = Get.put(AddQuestionController());
    //questionController.classSelected.value = classController.allClasses[0];
    final customToolBarList = [
      ToolBarStyle.bold,
      ToolBarStyle.italic,
      ToolBarStyle.underline,
      ToolBarStyle.strike,
      ToolBarStyle.blockQuote,
      ToolBarStyle.codeBlock,
      ToolBarStyle.indentAdd,
      ToolBarStyle.indentMinus,
      ToolBarStyle.headerOne,
      ToolBarStyle.headerTwo,
      ToolBarStyle.color,
      ToolBarStyle.align,
      ToolBarStyle.listBullet,
      ToolBarStyle.listOrdered,
      ToolBarStyle.size,
      ToolBarStyle.link,
      ToolBarStyle.video,
      ToolBarStyle.clean,
      ToolBarStyle.clearHistory,
      ToolBarStyle.undo,
      ToolBarStyle.redo,
      ToolBarStyle.addTable,
      ToolBarStyle.editTable,
    ];

    return Scaffold(
      appBar: LAppBar(
        title: Text("Add new Question",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        actions: [
          OutlinedButton(
              onPressed: () => addQuestionController.addQuestion(
                  addQuestionController.classSelected.value.id.toString(),
                  tagController.covertToListTag()),
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
                  controller: addQuestionController.title,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),

                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                Obx(
                  () => DropdownButtonFormField<ClassModel>(
                      decoration: const InputDecoration(labelText: "Class"),
                      items: addQuestionController.allClasses
                          .map((course) => DropdownMenuItem<ClassModel>(
                              value: course,
                              child: Text(
                                course.title ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )))
                          .toList(),
                      onChanged: (course) {
                        addQuestionController.setClassSelected(course!);
                      },
                      value: addQuestionController.classSelected.value),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),

                Row(
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
                              .map((tag) => LTagCard(
                                    tag: tag,
                                    showCancelBtn: true,
                                    maxline: 1,
                                    onCancel: () => tagController
                                        .removeTagFromSelected(tag),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.arrow_right_34),
                      iconSize: 18,
                      onPressed: () => Get.to(() => TagScreen(
                            classId:
                                addQuestionController.classSelected.value.id!,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                //AddImage(),
                //const SizedBox(
                 //height: LSizes.spaceBtwInputFields,
                //),
                Text(
                  "Description",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: LColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                ToolBar(
                  toolBarColor: LColors.primary1,
                  toolBarConfig: customToolBarList,
                  activeIconColor: LColors.secondary1,
                  padding: const EdgeInsets.all(8),
                  iconSize: 25,
                  controller: addQuestionController.controller,
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
                  child: QuillHtmlEditor(
                    hintText: 'Enter your answer',
                    controller: addQuestionController.controller,
                    isEnabled: true,
                    minHeight: 300,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    onFocusChanged: (hasFocus) =>
                        debugPrint('has focus $hasFocus'),
                    onTextChanged: (text) =>
                        debugPrint('widget text change $text'),
                    onEditorCreated: () => debugPrint('Editor has been loaded'),
                    onEditingComplete: (s) =>
                        debugPrint('Editing completed $s'),
                    onEditorResized: (height) =>
                        debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) =>
                        debugPrint('${sel.index},${sel.length}'),
                    loadingBuilder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 0.4,
                      ));
                    },
                  ),
                ),
                //const AddImage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
