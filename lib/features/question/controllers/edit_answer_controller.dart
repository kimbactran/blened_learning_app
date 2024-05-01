import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../common/widgets/loaders/loaders.dart';

class EditAnswerController extends GetxController{
  static EditAnswerController get instance => Get.find();

  final content = TextEditingController();
  final QuillEditorController controller = QuillEditorController();


  final answerRepository = AnswerRepository.instance;

  Future<void> editAnswer(String answerId) async {
    try {
      final content = await controller.getText();
      await answerRepository.editQuestion(answerId, content);
      LLoader.customToast(message: 'Add Answer Success!');
      Get.back();

    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
}
}