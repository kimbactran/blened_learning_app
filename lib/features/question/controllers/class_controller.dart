import 'dart:convert';

import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClassController extends GetxController {
  static ClassController get instance => Get.find();

  final isLoading = false.obs;
  RxBool refreshData = true.obs;
  RxBool refreshDataOnAns = true.obs;
  final orderStatus = 'HIGH_SCORES'.obs;
  RxList<ClassModel> allClasses = <ClassModel>[].obs;
  RxList<TagModel> allTag = <TagModel>[].obs;
  final deviceStorage = GetStorage();
  final classRepository = Get.put(ClassRepository());
  final questionRepository = Get.put(QuestionRepository());

  @override
  void onInit() {
    fetchClasses();
    super.onInit;
  }

  Future<void> fetchClasses() async {
    try {
      isLoading.value = true;
      // get data from API
      final courses = await classRepository.getAllClass();
      allClasses.assignAll(courses);
      // Assign number question in Class
      for(var course in allClasses) {
        final numStr = await questionRepository.numberQuestionInClass(course.id!);
        course.numberQuestion = numStr;
      }
      isLoading.value = false;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ClassModel>> getAllClasses() async {
    try {
      isLoading.value = true;
      // get data from API
      final courses = await classRepository.getAllClass();
      allClasses.assignAll(courses);
      // Assign number question in Class
      for(var course in allClasses) {
        final numStr = await questionRepository.numberQuestionInClass(course.id!);
        course.numberQuestion = numStr;
      }
      return allClasses;
    } catch (e) {

      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void changeOrder(String status) {
    orderStatus.value = status;
    refreshData.toggle();
  }

}