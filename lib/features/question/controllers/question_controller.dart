import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:blended_learning_appmb/utils/constants/enums.dart';
import 'package:quill_html_converter/quill_html_converter.dart';

import 'package:blended_learning_appmb/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quill_html_converter/quill_html_converter.dart';

import 'package:get/get.dart';

class QuestionController extends GetxController {
  static QuestionController get instance => Get.find();
  final deviceStorage = GetStorage();

  // Variable
  final title = TextEditingController();
  final isLoading = false.obs;
  final isUpVote = false.obs;
  final isDownVote = false.obs;
  final numUpVote = 0.obs;
  final numDownVote = 0.obs;
  RxBool refreshData = true.obs;
  TextEditingController questionText = TextEditingController();
  final classController = ClassController.instance;
  final answerRepository = Get.put(AnswerRepository());
  final questionRepository = QuestionRepository.instance;
  QuillController quillController = QuillController.basic();


  final comments = <String>[].obs;
  RxList<TagModel> tags = <TagModel>[].obs;
  Rx<ClassModel> classSelected = ClassModel.empty().obs;


  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    ever(classController.allClasses, (_) async {
      tags.assignAll(
          await questionRepository.getAllTags(classController.allClasses));
      classSelected.value = classController.allClasses[0];
    });
    isLoading.value = false;
  }
  Future<List<QuestionModel>> getQuestionByUser() async {
    try {
      final questions = await questionRepository.getQuestionByUser(classController.allClasses);
      List<QuestionModel> reversedQuestions =
      List.from(questions.reversed);
      reversedQuestions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
       return reversedQuestions;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<QuestionModel>> getQuestionInClassWithSort(String classId, String sort) async {
    try {
      final questions = await questionRepository.getQuestionInClassWithSort(classId, sort);
      return questions;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<QuestionModel> getQuestionDetail(String questionId) async{
    try {
      final question = await questionRepository.getQuestionDetail(questionId);
      return question;
    }catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return QuestionModel.empty();
    }
  }


  Future<void> addQuestion(String classroomId, List<String> tagIds) async {
    try {
      //LFullScreenLoader.openLoadingDialog(
          //'Loading...', LImages.loaderAnimation);
      if(title.text.trim().isEmpty || title.text.trim().trim().isEmpty ||
          quillController.document.toPlainText().trim().isEmpty
      || quillController.document.toPlainText().trim().trim().isEmpty|| tagIds.isEmpty) {
        LLoader.customToast(message: "Please enter full the title, description and tags!" );
      } else {
        String content = quillController.document.toDelta().toHtml();
        bool result =
        await questionRepository.addQuestion(title.text.trim(), content, classroomId, tagIds);
        if (result) {
          Get.back();
          LLoader.successSnackBar(title: "Create question successfully", message: "Let's check answer");
          refreshData.toggle();
          quillController.clear();
          quillController.dispose();
          quillController = QuillController.basic();
          title.clear();
        } else {
          LFullScreenLoader.stopLoading();
          LLoader.errorSnackBar(
              title: 'Oh Snap!',
              message: 'Something went wrong when add question!');
        }
      }
    } catch (error) {
      LFullScreenLoader.stopLoading();
      LLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }




  void likeQuestion(QuestionModel question) async {
    isUpVote.value = !isUpVote.value;
    if(isUpVote.value && isDownVote.value) {
      isDownVote.value = !isDownVote.value;
    }
      await questionRepository.likeQuestion(question, isUpVote.value);
      final questionUpdate = await questionRepository.getQuestionDetail(question.id!);
      numUpVote.value = questionUpdate.numUpVote!;
      numDownVote.value = questionUpdate.numDownVote!;
  }

  void dislikeQuestion(QuestionModel question) async {
    isDownVote.value = !isDownVote.value;
    if(isUpVote.value && isDownVote.value) {
      isUpVote.value = !isUpVote.value;
    }
    await questionRepository.dislikeQuestion(question, isDownVote.value);
    final questionUpdate = await questionRepository.getQuestionDetail(question.id!);
    numUpVote.value = questionUpdate.numUpVote!;
    numDownVote.value = questionUpdate.numDownVote!;

  }

  void setClassSelected(ClassModel value) {
    classSelected.value = value;
  }

void deleteQuestion(String questionId) async {
    try {
      await questionRepository.deleteQuestion(questionId);
      refreshData.toggle();
      LLoader.successSnackBar(title: "Delete Question Success!");
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
}
}