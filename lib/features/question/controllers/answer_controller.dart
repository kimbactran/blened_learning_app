import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerController extends GetxController {
  static AnswerController get intance => Get.find();
  TextEditingController commentText = TextEditingController();
  final comments = <String>[].obs;

  void addComment() {
    comments.add(commentText.text);
    commentText.clear();
  }
}
