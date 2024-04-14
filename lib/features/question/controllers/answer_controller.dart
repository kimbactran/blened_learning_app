import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';

class AnswerController extends GetxController {
  static AnswerController get instance => Get.find();
  RxBool refreshData = true.obs;
  RxBool refreshDataOnAns = true.obs;
  final orderStatus = 'HIGH_SCORES'.obs;



  final commentText = TextEditingController();
  final commentSubText = TextEditingController();
  Rx<AnswerModel> anwsers = AnswerModel.empty().obs;
  final comments = <String>[].obs;
  final answerRepository = Get.put(AnswerRepository());

  Future<List<AnswerModel>> getCommentOfPost(
      String classId, String postId, String order) async {
    try {
      // Fetch Products
      final answers = await answerRepository.getAnswerOfPost(postId, classId, order);
      return answers.where((answer) => answer.parentId == null).toList();
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<AnswerModel>> getAnswerOfAnswer(
  String classId, String postId, String answerId, String order) async {
    try {
      // Fetch Products
      final answers = await answerRepository.getAnswerOfPost(postId, classId, order);
      return answers.where((answer) => answer.parentId == answerId).toList();
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future addComment(String postId, String classId) async {
    try {
      await answerRepository.addComment(
          commentText.text.trim(), postId, classId);
      LLoader.customToast(message: 'Add Answer Success!');
      refreshData.toggle();

      commentText.clear();
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future addAnswerOfAnswer(String postId, String classId, String parentId) async {
    try {
      await answerRepository.addAnswerOfAnswer(
          commentSubText.text.trim(), postId, classId, parentId);
      LLoader.customToast(message: 'Add Answer Success!');
      refreshDataOnAns.toggle();

      commentSubText.clear();
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void changeOrder(String status) {
    orderStatus.value = status;
     refreshData.toggle();

  }

  void deleteAnswer(String answerId) async {
    try {
      await answerRepository.deleteAnswer(answerId);
      refreshData.toggle();

      LLoader.successSnackBar(title: "Delete Question Success!");
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}
