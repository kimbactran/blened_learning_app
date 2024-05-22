import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/question/question_repository.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/tag_model.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class EditQuestionController extends GetxController{
  static EditQuestionController get instance => Get.find();

  final deviceStorage = GetStorage();
  QuillController quillController = QuillController.basic();
  final title = TextEditingController();
  final QuillEditorController controller = QuillEditorController();
  final questionRepository = QuestionRepository.instance;
  RxList<TagModel> tags = <TagModel>[].obs;

  void editQuestion(String postId, String classroomId, List<String> tagIds) async {
    try {
      if(title.text.trim().isEmpty || title.text.trim().trim().isEmpty ||
          quillController.document.toPlainText().trim().isEmpty
          || quillController.document.toPlainText().trim().trim().isEmpty|| tagIds.isEmpty) {
        LLoader.customToast(message: "Please enter full the title, description and tags!" );
      } else {
        String content = await controller.getText();
        bool result =
            await questionRepository.editQuestion(postId,title.text.trim(), content, classroomId, tagIds);
        if (result) {
          Get.back();
          LLoader.successSnackBar(title: "Edit question successfully", message: "Let's check answer");
        } else {
          LFullScreenLoader.stopLoading();
          LLoader.errorSnackBar(
              title: 'Oh Snap!',
              message: 'Something went wrong when edit question!');
        }
      }
    } catch (error) {
      LFullScreenLoader.stopLoading();
      LLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}