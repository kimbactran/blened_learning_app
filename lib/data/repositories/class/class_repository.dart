import 'dart:convert';

import 'package:blended_learning_appmb/features/question/models/class_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClassRepository extends GetxController {
  static ClassRepository get instance => Get.find();

  // Variable
  RxList<ClassModel> allClasses = <ClassModel>[].obs;
  final deviceStorage = GetStorage();

  Future<http.Response> getAllClass() async {
    try {
      String userId = deviceStorage.read('User Id');
      String token = deviceStorage.read('Token');
      var endpoint = LApi.classroomApi.listClassroomOfUser + '/${userId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        allClasses.assignAll(
            jsonList.map((classes) => ClassModel.fromJson(classes)).toList());
        return response;
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      final message = e.toString();
      throw '$message. Please try again!';
    }
  }
}
