import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/class/class_repository.dart';
import '../../personalization/models/user_model.dart';

class SearchUserController extends GetxController {
  static SearchUserController get instance => Get.find();


  final keyword = TextEditingController();
  final classRepository = ClassRepository.instance;
  final List<UserModel> users = <UserModel>[];
   RxList<UserModel> userFilter = <UserModel>[].obs;

  @override
  void onInit() async {
    //fetchClasses();
    super.onInit;
    final listUsers = await getUserEnable();
    users.assignAll(listUsers);
    userFilter.assignAll(listUsers);
  }


  Future<List<UserModel>> getUserEnable() async {
    try {
      // get data from API
      final users = await classRepository.getAllUser();
      print(users.length);
      return users;
    } catch (e) {
      LLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  searchUser() {
    List<UserModel> filterList = [];
    filterList = users.where((user) {
      return user.nameAndRole.toLowerCase().contains(keyword.text.toLowerCase());
    }).toList();

    userFilter.value = filterList;
  }

}