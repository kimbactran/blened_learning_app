import 'dart:convert';

import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/question_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuestionRepository extends GetxController {
  static QuestionRepository get instance => Get.find();
  final classRepository = ClassRepository.instance;

  // Variable
  final deviceStorage = GetStorage();
  RxList<QuestionModel> allQuestion = <QuestionModel>[].obs;

  Future<List<QuestionModel>> getQuestionInClass(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.postApi.postInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList
            .map((classes) => QuestionModel.fromJson(classes))
            .toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<QuestionModel>> getQuestionByUser(
      List<ClassModel> classes) async {
    try {
      for (var course in classes) {
        // Lấy lớp
        List<QuestionModel> questions = await getQuestionInClass(course.id!);
        allQuestion.addAll(questions);
      }
      return allQuestion;
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<String> numberQuestionInClass(String classId) async {
    try {
      List<QuestionModel> questions = await getQuestionInClass(classId);
      return questions.length.toString();
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }
}
