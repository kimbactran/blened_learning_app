import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:blended_learning_appmb/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../models/answer_model.dart';

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
  List<ClassModel> allClasses = <ClassModel>[].obs;
  RxBool refreshData = true.obs;
  TextEditingController questionText = TextEditingController();

  TextEditingController commentText = TextEditingController();

  final classController = ClassController.instance;
  final answerRepository = AnswerRepository.instance;
  final questionRepository = QuestionRepository.instance;
  QuillController quillController = QuillController.basic();
  final QuillEditorController controller = QuillEditorController();


  final comments = <String>[].obs;
  RxList<TagModel> tags = <TagModel>[].obs;
  Rx<ClassModel> classSelected = ClassModel.empty().obs;


  @override
  void onInit() async {
    super.onInit();
    final courses = await classController.getAllClasses();
    if (courses.isNotEmpty) {
      allClasses.addAll(courses);
      classSelected.value = courses.first;
      tags.assignAll(await questionRepository.getAllTags(allClasses));
    }

    ever(classController.allClasses, (_) async {
      if (classController.allClasses.isNotEmpty) {
        classSelected.value = classController.allClasses[0];
      }
    });
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
          tagIds.isEmpty) {
        LLoader.customToast(message: "Please enter full the title, description and tags!" );
      } else {
        String? htmlText = await controller.getText();
        bool result =
        await questionRepository.addQuestion(title.text.trim(), htmlText, classroomId, tagIds);
        if (result) {
          Get.back();
          LLoader.successSnackBar(title: "Create question successfully", message: "Let's check answer");
          refreshData.toggle();
          controller.clear();
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

  @override
  void onClose() {
    questionText.dispose();
    super.onClose();
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


  Future<List<QuestionModel>> getQuestionOfUser() async {
    try {
      final questions = await questionRepository.getQuestionOfUser(classController.allClasses);
      List<QuestionModel> reversedQuestions =
      List.from(questions.reversed);
      reversedQuestions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      return reversedQuestions;
    }catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<QuestionModel>> getQuestionOfTag(TagModel tag) async {
    try {
      final questions = await questionRepository.getQuestionOfTag(classController.allClasses, tag);
      List<QuestionModel> reversedQuestions =
      List.from(questions.reversed);
      reversedQuestions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      return reversedQuestions;
    }catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }



  Future<List<AnswerModel>> getAnswerOfUser() async {
    try {
      List<QuestionModel> questions = await questionRepository.getQuestionByUser(classController.allClasses);
      print(questions.length);
        List<AnswerModel> answers = await answerRepository.getAnswerOfPostSortByUser(questions, 'HIGH_SCORES');
        print(answers.length);
      List<AnswerModel> reversedAnswers =
      List.from(answers.reversed);
      reversedAnswers.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      return reversedAnswers;
    }catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
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
