import 'package:blended_learning_appmb/features/question/controllers/question_controller.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EcoQuillText extends StatelessWidget {
  const EcoQuillText({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;

    return SafeArea(
        child: Column(
      children: [
        // QuillToolbar.simple(
        //   configurations: QuillSimpleToolbarConfigurations(
        //     controller: questionController.quillController,
        //     sharedConfigurations: const QuillSharedConfigurations(
        //       locale: Locale('en'),
        //     ),
        //   ),
        // ),
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
          // child: QuillEditor.basic(
          //   configurations: QuillEditorConfigurations(
          //     controller: questionController.quillController,
          //     sharedConfigurations: const QuillSharedConfigurations(
          //       locale: Locale('en'),
          //     ),
          //   ),
          // ),
        ),
      ],
    ));
  }
}
