import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:get/get.dart';

import '../data/repositories/answer/answer_repository.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../features/question/controllers/question_controller.dart';
import '../features/question/controllers/tag_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());
    Get.put(QuestionRepository());
    Get.put(AnswerRepository());
    Get.put(ClassController());
    Get.put(TagController());
  }
}
