import 'dart:convert';

import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/data/repositories/tag_repository/tag_repository.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClassController extends GetxController {
  static ClassController get instance => Get.find();

  final isLoading = false.obs;
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
      var response = await classRepository.getAllClass();

      List jsonList = jsonDecode(response.body);
      allClasses.assignAll(
          jsonList.map((course) => ClassModel.fromJson(course)).toList());

      // Assign number question in Class
      allClasses.map((course) async => course.numberQuestion =
          await questionRepository.numberQuestionInClass(course.id!));

      // String userId = deviceStorage.read('User Id');
      // String token = deviceStorage.read('Token');
      // var url = Uri.parse(
      //     'http://192.168.2.110:3001/v1/classrooms/classrooms-by-user/${userId}');
      // var response = await http.get(
      //   url,
      //   headers: {
      //     "Authorization": "Bearer ${token}",
      //   },
      // );
      // if (response.statusCode == 200) {
      //   print("get data success");
      //   List jsonList = jsonDecode(response.body);
      //   allClasses.assignAll(
      //       jsonList.map((classes) => ClassModel.fromJson(classes)).toList());
      //   print(allClasses.map((element) => element.title));
      // }
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
