import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  static CommentController get intance => Get.find();
  TextEditingController commentText = TextEditingController();
  final comments = <String>[].obs;

  void addComment() {
    comments.add(commentText.text);
    commentText.clear();
  }
}
