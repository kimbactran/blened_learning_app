import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/question/question_repository.dart';
import '../models/answer_model.dart';
import '../models/class_model.dart';
import '../models/user_attribute.dart';
import 'class_controller.dart';

class RankController extends GetxController {
  static RankController get instance => Get.find();

  List<ClassModel> allClasses = <ClassModel>[].obs;

  final classController = ClassController.instance;
  final classRepository = ClassRepository.instance;
  final questionRepository = QuestionRepository.instance;
  final answerRepository = AnswerRepository.instance;

  @override
  void onInit() async {
    super.onInit();
    final courses = await classController.getAllClasses();
    allClasses.addAll(courses);
  }

  Future<List<UserAttributeModel>> getAttributeOfUser(String classId) async {
    try {
      final questions = await questionRepository.getQuestionInClass(classId);
      List<AnswerModel> answers = [];
      for (var question in questions) {
        final answer = await answerRepository.getAnswerOfPost(
            question.id!, "", 'HIGH_SCORES');
        answers.addAll(answer);
      }
      List<UserAttributeModel> userAttributes = [];
      final users = await classRepository.getUserOfClass(classId);
      for (var user in users) {
        final UserAttributeModel userAttribute = UserAttributeModel.empty();
        userAttribute.user = user;
        int numQuestions = 0;
        int numAnswers = 0;
        int numLike = 0;
        int numDislike = 0;

        for (var question in questions.toList()) {
          if (question.user?.id == user.id) {
            numQuestions = numQuestions + 1;
            numLike = numLike + question.numUpVote!;
            numDislike = numDislike + question.numDownVote!;
            questions.remove(question);
          }
        }

        for (var answer in answers.toList()) {
          if (answer.user?.id == user.id) {
            numAnswers = numAnswers + 1;
            numLike = numLike + answer.numUpVote!;
            numDislike = numDislike + answer.numDownVote!;
            answers.remove(answer);
          }
        }
        userAttribute.numQuestion = numQuestions;
        userAttribute.numAnswer = numAnswers;
        userAttribute.numLike = numLike;
        userAttribute.numDislike = numDislike;
        userAttributes.add(userAttribute);
      }
      userAttributes.sort((a, b) => (b.numQuestion! + b.numAnswer!)
          .compareTo(a.numQuestion! + a.numAnswer!));
      return userAttributes;
    } catch (e) {
      LLoader.errorSnackBar(
          title: 'Oh Snap! Something went wrong while get user attribute.',
          message: e.toString());
      print(e.toString());
      return [];
    }
  }
}
