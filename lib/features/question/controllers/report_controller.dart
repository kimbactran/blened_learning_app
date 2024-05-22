import 'package:blended_learning_appmb/data/repositories/answer/answer_repository.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/data/repositories/tag_repository/tag_repository.dart';
import 'package:blended_learning_appmb/features/question/models/answer_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../models/class_model.dart';
import '../models/question_model.dart';
import '../models/report_model.dart';
import '../models/tag_report_model.dart';
import '../models/user_attribute.dart';

class ReportController extends GetxController{
  static ReportController get instance => Get.find();

  final questionRepository = QuestionRepository.instance;
  final classRepository = ClassRepository.instance;
  final answerRepository = Get.put(AnswerRepository());
  final tagRepository = TagRepository.instance;
  List<QuestionModel> questions = [];

  Future<TagReportModel> getReportOfTag(String classId, TagModel tag) async {
    try {
      TagReportModel tagReport = TagReportModel.empty();
      int numAnswer =0;
      int numLike = 0;
      int numDislike = 0;
      tagReport.tag = tag;
      final questions = await questionRepository.getQuestionsOfTag(classId, tag);
      tagReport.numQuestion = questions.length;

      for(var question in questions) {
        numLike = numLike + question.numUpVote!;
        numDislike = numDislike + question.numDownVote!;
        final answer = await answerRepository.getAnswerOfPost(question.id!, "",'HIGH_SCORES');
        numAnswer = numAnswer + answer.length;
      }
      tagReport.numAnswer = numAnswer;
      tagReport.numLike = numLike;
      tagReport.numDislike = numDislike;
      return tagReport;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return TagReportModel.empty();
    }
  }

  Future<List<UserAttributeModel>> getAttributeOfUser(String classId, List<QuestionModel> questionsOfClass, List<AnswerModel> answersOfClass) async {
    try {
      List<UserAttributeModel> userAttributes = [];
      final users = await classRepository.getUserOfClass(classId);
      final answers = answersOfClass;
      final questions = questionsOfClass;
      for(var user in users) {
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
      userAttributes.sort((a, b) => (b.numQuestion! + b.numAnswer!).compareTo(a.numQuestion! + a.numAnswer!));
      return userAttributes;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap! Something went wrong while get user attribute.', message: e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<ReportModel> getReportOfClass(ClassModel course) async {
    try {
      ReportModel report = ReportModel.empty();
      report.course = course;
      final questions = await questionRepository.getQuestionInClass(course.id!);
      List<AnswerModel> answers = [];
      int numLike = 0;
      int numDislike = 0;
      for(var question in questions) {
        numLike = numLike + question.numUpVote!;
        numDislike = numDislike + question.numDownVote!;
        final answer = await answerRepository.getAnswerOfPost(question.id!, "", 'HIGH_SCORES');
        answers.addAll(answer);
      }
      report.numQuestions = questions.length;
      report.numAnswers = answers.length;
      report.numLikes = numLike;
      report.numDislike = numDislike;

      List<UserAttributeModel> userAttributes = await getAttributeOfUser(course.id!, questions, answers);
      report.userAttributes = userAttributes;
      List<TagReportModel> tagReports = [];
      final tags = await tagRepository.getAllTag(course.id!);
      for(var tag in tags) {
        final tagReport = await getReportOfTag(course.id!, tag);
        tagReports.add(tagReport);
      }
      tagReports.sort((a, b) => (b.numQuestion! + b.numAnswer!).compareTo(a.numQuestion! + a.numAnswer!));
      report.tagReports = tagReports;
      return report;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return ReportModel.empty();
    }
  }
}