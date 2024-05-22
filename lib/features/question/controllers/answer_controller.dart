import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AnswerController extends GetxController {
  static AnswerController get instance => Get.find();
  RxBool refreshData = true.obs;
  RxBool refreshDataOnAns = true.obs;
  final orderStatus = 'HIGH_SCORES'.obs;
  final isUpVote = false.obs;
  final isDownVote = false.obs;
  final numUpVote = 0.obs;
  final numDownVote = 0.obs;



  final commentText = TextEditingController();
  final commentSubText = TextEditingController();
  final answerRepository = AnswerRepository.instance;

  Future<List<AnswerModel>> getCommentOfPost(
       String postId, String classId, String order) async {
    try {
      // Fetch Products
      List<AnswerModel> answers = await answerRepository.getAnswerOfPost(postId, classId, order);
      return answers.where((answer) => answer.parentId == null).toList();
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!, Something went wrong while load comment!', message: e.toString());
      return [];
    }
  }

  Future<int> getNumCommentOfPost(
      String classId, String postId, String order) async {
    try {
      // Fetch Products
      final answers = await answerRepository.getAnswerOfPost(postId, classId, order);
      final answersOfPost =  answers.where((answer) => answer.parentId == null).toList();
      return answersOfPost.length;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return 0;
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

  void likeAnswer(AnswerModel answer) async {
    print(answer.numUpVote);
    isUpVote.value = !isUpVote.value;if(isUpVote.value) {
      numUpVote.value = numUpVote.value + 1;
    } else {
      numUpVote.value = numUpVote.value - 1;
    }

    if(isUpVote.value && isDownVote.value) {
      isDownVote.value = !isDownVote.value;
      numDownVote.value = numDownVote.value - 1;

    }
    await answerRepository.likeAnswer(answer, isUpVote.value);
  }

  void dislikeAnswer(AnswerModel answer) async {
    isDownVote.value = !isDownVote.value;
    if(isDownVote.value) {
      numDownVote.value = numDownVote.value + 1;
    } else {
      numDownVote.value = numDownVote.value - 1;
    }
    if(isUpVote.value && isDownVote.value) {
      isUpVote.value = !isUpVote.value;
      numUpVote.value = numUpVote.value - 1;
    }
    await answerRepository.dislikeAnswer(answer, isDownVote.value);

  }

}
