import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  static QuestionController get instance => Get.find();

  // Variable
  TextEditingController questionText = TextEditingController();
  final questions = <String>[].obs;
  RxString question = ''.obs;
  TextEditingController commentText = TextEditingController();
  final classController = Get.put(ClassController());
  final questionRepository = QuestionRepository.instance;
  final QuillController _quillController = QuillController.basic();

  final comments = <String>[].obs;

  RxList<QuestionModel> allQuestions = <QuestionModel>[].obs;

  void addComment() {
    comments.add(commentText.text);
    commentText.clear();
  }

  @override
  void onInit() {
    super.onInit();
    questionText.addListener(updateQuestion);
    ever(classController.allClasses, (_) async {
      await questionRepository.getQuestionByUser(classController.allClasses);

      allQuestions.assignAll(questionRepository.allQuestion);
    });
  }

  void updateQuestion() {
    question.value = questionText.text;
  }

  Future<void> getQuestionInClass(String classId) async {
    try {} catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Future<QuestionModel> getQuestion() async {
  //   try {

  //   } catch (e) {
  //           LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //           return QuestionModel.empty()
  //   }
  // }

  @override
  void onClose() {
    questionText.dispose();
    super.onClose();
  }

  void addShowText() {}

  void addQuestion() async {
    questions.add(questionText.text);
    questionText.clear();
    Get.back();
  }
}
