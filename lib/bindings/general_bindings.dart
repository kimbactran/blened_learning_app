import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/utils/networks/network_manager.dart';
import 'package:get/get.dart';

import '../features/question/controllers/question_controller.dart';
import '../features/question/controllers/tag_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ClassController());
    Get.put(TagController());
    Get.put(QuestionController());
  }
}
