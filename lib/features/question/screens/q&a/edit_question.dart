
import 'package:blended_learning_appmb/features/question/controllers/edit_question_controller.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/utils/helpers/permission_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/tag_card/tag_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/tag_controller.dart';
import '../tag/tag.dart';

class EditQuestionScreen extends StatelessWidget {
  const EditQuestionScreen({super.key, required this.question});
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final editQuestionController = Get.put(EditQuestionController());
    final tagController = Get.put(TagController());
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
    editQuestionController.title.text = question.title!;
    editQuestionController.quillController.document = Document()..insert(0, question.content!);
    editQuestionController.tags.assignAll(question.tags!);
    tagController.selectedTags.assignAll(question.tags!);
    requestStoragePermission();
    return Scaffold(
      appBar: LAppBar(
        title: Text("Edit Question",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        actions: [
          OutlinedButton(
              onPressed: () => editQuestionController
                  .editQuestion(question.id!, question.classId!, tagController.covertToListTag()),
              child: const Text("Edit question"))
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
                  controller: editQuestionController.title,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),
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
                                    .map((tag) => LTagCard(tag: tag, showCancelBtn: true, maxline: 1,
                                  onCancel: () => tagController.removeTagFromSelected(tag),))
                                    .toList(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Iconsax.arrow_right_34),
                            iconSize: 18,
                            onPressed: () => Get.to(() => TagScreen(
                              classId: question.classId!,
                            )),
                          ),
                        ],
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
                ToolBar(
                  toolBarColor: LColors.primary1,
                  toolBarConfig: customToolBarList,
                  activeIconColor: LColors.secondary1,
                  padding: const EdgeInsets.all(8),
                  iconSize: 25,
                  controller: editQuestionController.controller,
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
                  child:  QuillHtmlEditor(
                    text: question.content,
                    hintText: 'Enter your answer',
                    controller: editQuestionController.controller,
                    isEnabled: true,
                    minHeight: 300,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
                    onTextChanged: (text) => debugPrint('widget text change $text'),
                    onEditorCreated: () => debugPrint('Editor has been loaded'),
                    onEditingComplete: (s) => debugPrint('Editing completed $s'),
                    onEditorResized: (height) =>
                        debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) =>
                        debugPrint('${sel.index},${sel.length}'),
                    loadingBuilder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 0.4,
                          ));},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

