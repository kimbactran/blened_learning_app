import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:get/get.dart';

import '../../../data/repositories/answer/answer_repository.dart';
import '../models/answer_model.dart';
import '../models/question_model.dart';

class VoteController extends GetxController {
  static VoteController get instance => Get.find();
  final questionRepository = QuestionRepository.instance;
  final answerRepository = AnswerRepository.instance;

  final numUpVote = 0.obs;
  final numDownVote = 0.obs;

  void likeQuestion(QuestionModel question, bool isUpVote) async {
    await questionRepository.likeQuestion(question, isUpVote);
    final questionUpdate = await questionRepository.getQuestionDetail(question.id!);
    numUpVote.value = questionUpdate.numUpVote!;
    numDownVote.value = questionUpdate.numDownVote!;
  }

  void dislikeQuestion(QuestionModel question, bool isDownVote) async {
    await questionRepository.dislikeQuestion(question, isDownVote);
    final questionUpdate = await questionRepository.getQuestionDetail(question.id!);
    numUpVote.value = questionUpdate.numUpVote!;
    numDownVote.value = questionUpdate.numDownVote!;
  }

  void likeAnswer(AnswerModel answer, bool isUpVote) async {

    await answerRepository.likeAnswer(answer, isUpVote);
  }

  void dislikeAnswer(AnswerModel answer, bool isDownVote) async {
    await answerRepository.dislikeAnswer(answer, isDownVote);
  }
}