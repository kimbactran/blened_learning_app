import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EcoQuillText extends StatelessWidget {
  const EcoQuillText({super.key});

  @override
  Widget build(BuildContext context) {
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
