import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/post_contoller.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewQuestionScreen extends StatelessWidget {
  const AddNewQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    return Scaffold(
      appBar: LAppBar(
        title: Text("Add new Question",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        actions: [
          OutlinedButton(
              onPressed: postController.addQuestion,
              child: const Text("Add question"))
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(LSizes.lg),
            child: Column(
              children: [
                // Obx(() => Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         LRoundedContainer(
                //             showBorder: true,
                //             padding: EdgeInsets.all(LSizes.sm),
                //             child: Text(postController.question.value)),
                //         SizedBox(
                //           height: LSizes.spaceBtwItems,
                //         )
                //       ],
                //     )),
                TextField(
                  controller: postController.questionText,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "Enter your question here",
                      border: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
