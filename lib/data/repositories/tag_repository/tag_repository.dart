import 'dart:convert';

import 'package:blended_learning_appmb/features/question/models/tag_model.dart';
import 'package:blended_learning_appmb/features/question/models/tree_tag_model.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:blended_learning_appmb/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/question/models/class_model.dart';

class TagRepository extends GetxController {
  static TagRepository get instance => Get.find();

  // Variable
  final deviceStorage = GetStorage();

  Future<TreeTagModel> getSyllabus(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.tagApi.tagInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        List<Map<String, dynamic>> typedJsonList =
            List<Map<String, dynamic>>.from(jsonList);
        TreeTagModel treeTagModel = TreeTagModel();
        TreeTagModel treeNode = treeTagModel.convertFromList(typedJsonList);
        return treeNode;
      }
      throw ('Something went wrong while getting the syllabus. Status code: ${response.statusCode}');
    } catch (e) {
      print(e.toString());
      throw ('Something went wrong while getting the syllabus. ${e.toString()}');
    }
  }

  Future<List<TagModel>> getAllTag(String classId) async {
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.tagApi.tagInClassroom + '/${classId}';
      var response = await LHttpHelper.get(endpoint, token);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);

        return jsonList.map((classes) => TagModel.fromJson(classes)).toList();
      }
      throw ('Something went wrong while getting the syllabus. Status code: ${response.statusCode}');
    } catch (e) {
      print(e.toString());
      throw ('Something went wrong while getting the syllabus. ${e.toString()}');
    }
  }

  Future<List<TagModel>> getAllTagOfUser(List<ClassModel> courses) async {
    try {
      String token = deviceStorage.read('Token');
      List<TagModel> tags = [];
      for(var course in courses) {
        var endpoint = LApi.tagApi.tagInClassroom + '/${course.id}';
        var response = await LHttpHelper.get(endpoint, token);
        if (response.statusCode == 200) {
          List jsonList = jsonDecode(response.body);

          tags.addAll(jsonList.map((classes) => TagModel.fromJson(classes)).toList());
        }
        throw ('Something went wrong while getting the syllabus. Status code: ${response.statusCode}');
      }
      return tags;

    } catch (e) {
      print(e.toString());
      throw ('Something went wrong while getting the syllabus. ${e.toString()}');
    }
  }

  Future addNewFreeTag(String classId, List<String> tags) async{
    try {
      String token = deviceStorage.read('Token');
      var endpoint = LApi.tagApi.tagFree;
      Map data = {
        "classroomId": classId,
        "tags": tags
      };
      var response = await LHttpHelper.post(endpoint, data, token);
      if(response.statusCode == 200) {
        if (response.statusCode == 200) {

        } else {
          throw Exception('Failed to add free tag ${response.statusCode}');
        }
      }
    }catch (e) {
      print(e.toString());
      throw ('Something went wrong while add syllabus. ${e.toString()}');
    }
  }
}
