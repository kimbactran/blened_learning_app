import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/edit_answer_controller.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class EditAnswerScreen extends StatelessWidget {
  const EditAnswerScreen({super.key, required this.answer});

  final AnswerModel answer;

  @override
  Widget build(BuildContext context) {
    final editAnswerController = Get.put(EditAnswerController());

    return Scaffold(appBar: const LAppBar(title: Text('Edit question'), showBackArrow: true,),
    body: Padding(
      padding: const EdgeInsets.all(LSizes.sm),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Màu sắc của viền
                width: 2.0, // Độ dày của viền
              ),
            ),
            height: 200,
            child:  QuillHtmlEditor(
              text: answer.content,
              hintText: 'Enter your answer',
              controller: editAnswerController.controller,
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
          SizedBox(height: LSizes.spaceBtwItems,),
          ElevatedButton(onPressed: () => editAnswerController.editAnswer(answer.id!), child: const Text('Change Answer'))
        ],
      ),
    ),
    );
  }
}
