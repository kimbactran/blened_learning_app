import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController get intance => Get.find();
  TextEditingController questionText = TextEditingController();
  final questions = <String>[].obs;
  RxString question = ''.obs;
  TextEditingController commentText = TextEditingController();
  final comments = <String>[].obs;

  void addComment() {
    comments.add(commentText.text);
    commentText.clear();
  }

  @override
  void onInit() {
    super.onInit();
    questionText.addListener(updateQuestion);
  }

  void updateQuestion() {
    question.value = questionText.text;
  }

  @override
  void onClose() {
    questionText.dispose();
    super.onClose();
  }

  void addShowText() {}

  void addQuestion() {
    questions.add(questionText.text);
    questionText.clear();
    Get.back();
  }
}
