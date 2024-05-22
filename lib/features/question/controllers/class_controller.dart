import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/class/class_repository.dart';
import 'package:blended_learning_appmb/data/repositories/question/question_repository.dart';
import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../personalization/models/user_model.dart';

class ClassController extends GetxController {
  static ClassController get instance => Get.find();

  RxBool refreshData = true.obs;
  RxBool refreshListUserData = true.obs;
  RxBool refreshDataOnAns = true.obs;
  final orderStatus = 'HIGH_SCORES'.obs;
  RxList<ClassModel> allClasses = <ClassModel>[].obs;
  RxList<TagModel> allTag = <TagModel>[].obs;
  RxList<UserModel> usersSelected = <UserModel>[].obs;
  RxList<UserModel> usersEnable = <UserModel>[].obs;

  final deviceStorage = GetStorage();
  final classRepository = Get.put(ClassRepository());
  final questionRepository = Get.put(QuestionRepository());

  @override
  void onInit() async {
    //fetchClasses();
    super.onInit;
  }

  Future<void> fetchClasses() async {
    try {
      // get data from API
      final courses = await classRepository.getAllClass();
      allClasses.assignAll(courses);
      // Assign number question in Class
      for(var course in allClasses) {
        final numStr = await questionRepository.numberQuestionInClass(course.id!);
        course.numberQuestion = numStr;
      }
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<List<ClassModel>> getAllClasses() async {
    try {
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

  Future<List<UserModel>> getUserOfClass(String classId) async {
    try {
      // get data from API
      final users = await classRepository.getUserOfClass(classId);
      return users;

    } catch (e) {

      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<UserModel>> getUserEnable(String classId) async {
    try {
      // get data from API
      final users = await classRepository.getUserEnable(classId);
      return users;
    } catch (e) {

      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }




  void changeOrder(String status) {
    orderStatus.value = status;
    refreshData.toggle();
  }

  void removeFromSelectedUserList(UserModel user) {
    usersSelected.remove(user);
    usersEnable.add(user);
  }

  void addUserToSelectedUserList(UserModel user) {
    usersSelected.add(user);
    usersEnable.remove(user);
  }

  void addUserToClass(UserModel user, String classId) async{
    try {
      await classRepository.addUserInClass(classId, user);
      refreshListUserData.toggle();
      LLoader.customToast(message: 'Add user to class successfully!');
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void removeUserFromClass(UserModel user, String classId) async{
    try {
      await classRepository.removeUserFromClass(classId, user);
      refreshListUserData.toggle();
      LLoader.customToast(message: 'Remove user from class successfully!');
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}