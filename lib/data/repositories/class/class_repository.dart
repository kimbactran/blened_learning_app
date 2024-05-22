import 'dart:convert';

import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/personalization/models/user_model.dart';

class ClassRepository extends GetxController {
  static ClassRepository get instance => Get.find();

  // Variable
  RxList<ClassModel> allClasses = <ClassModel>[].obs;
  //RxList<UserModel> usersInClass = <UserModel>[].obs;

  final deviceStorage = GetStorage();

  Future<List<ClassModel>> getAllClass() async {
    try {
      String userId = deviceStorage.read('User Id');
      String token = deviceStorage.read('Token');
      var endpoint = LApi.classroomApi.listClassroomOfUser + '/${userId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        allClasses.assignAll(
            jsonList.map((classes) => ClassModel.fromJson(classes)).toList());
        return allClasses;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<UserModel>> getUserOfClass(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.userApi.userInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        final users =
            jsonList.map((user) => UserModel.fromJson(user)).toList();
        return users;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<UserModel>> getUserEnable(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.userApi.user;
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        final users = await getUserOfClass(classId);
        final userIds = users.map((user) => user.id).toSet();
        final allUsers =
        jsonList.map((classes) => UserModel.fromJson(classes)).toList();
        final enabledUsers = allUsers.where((user) => !userIds.contains(user.id)).toList();
        return enabledUsers;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.userApi.user;
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        final users =
        jsonList.map((user) => UserModel.fromJson(user)).toList();
        return users;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }

  Future<bool> addUserInClass(String classId, UserModel user) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.classroomApi.addUserInClassroom;
      Map body =  {
        'classroomId': classId,
        'userIds': [user.id],
      };
      var response = await LHttpHelper.post(endpoint, body, token);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add user ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }
  Future<bool> removeUserFromClass(String classId, UserModel user) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.classroomApi.removeUserInClassroom;
      Map body =  {
        'classroomId': classId,
        'userId': user.id,
      };
      var response = await LHttpHelper.post(endpoint, body, token);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add user ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }



}
