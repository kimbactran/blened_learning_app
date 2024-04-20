import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/question/question_repository.dart';
import '../models/class_model.dart';
import '../models/question_model.dart';

class SearchQuestionController extends GetxController{
  static SearchQuestionController get instance => Get.find();

  final keyword = TextEditingController();
  RxBool refreshData = true.obs;



  final questionRepository = QuestionRepository.instance;
  final classController = ClassController.instance;
  Rx<ClassModel> classSelected = ClassModel.empty().obs;

  @override
  void onInit() async {
    super.onInit();
    keyword.addListener(() => refreshData.toggle());
    ever(classController.allClasses, (_) async {
      classSelected.value = classController.allClasses[0];
    });


  }

  void setClassSelected(ClassModel value) {
    classSelected.value = value;
    refreshData.toggle();
  }

  Future<List<QuestionModel>> getSearchQuestion() async {
    try {
      final questions = await questionRepository.searchQuestion(keyword.text.trim(), classSelected.value.id!, "DESC");
      return questions;
    }catch (e) {

      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }



}