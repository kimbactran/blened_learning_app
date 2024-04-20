import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/answer/answer_repository.dart';
import '../../../data/repositories/question/question_repository.dart';
import '../models/class_model.dart';
import '../models/tag_model.dart';

class EditQuestionController extends GetxController{
  static EditQuestionController get instance => Get.find();

  final deviceStorage = GetStorage();
  QuillController quillController = QuillController.basic();


  final title = TextEditingController();
  Rx<ClassModel> classSelected = ClassModel.empty().obs;

  // Variable
  final isLoading = false.obs;
  RxBool refreshData = true.obs;

  RxString classSelectedId = ''.obs;


  TextEditingController questionText = TextEditingController();
  final questions = <String>[].obs;
  final classController = Get.put(ClassController());
  final answerRepository = Get.put(AnswerRepository());
  final questionRepository = QuestionRepository.instance;



  RxList<QuestionModel> allQuestions = <QuestionModel>[].obs;
  RxList<TagModel> tags = <TagModel>[].obs;

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


}