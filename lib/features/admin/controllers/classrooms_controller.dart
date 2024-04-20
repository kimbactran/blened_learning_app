import 'dart:convert';

import 'package:blended_learning_appmb/models/classrooms_model.dart';
import 'package:blended_learning_appmb/features/admin/viewDetailClass.dart';
import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClassroomsController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;
  var classrooms = <ClassroomModel>[].obs;

  TextEditingController statusText = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    getClassrooms();
  }

  getClassrooms() async {
    try {
      isLoading(true);
      final SharedPreferences? prefs = await _prefs;
      var token = prefs?.get('token').toString();
      var url = Uri.parse(LApi.baseUrl + LApi.classroomApi.classroom);
      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${token}",
      });
      if (response.statusCode == 200) {
        ///data successfully
        var data = List<ClassroomModel>.from(jsonDecode(response.body)
            .map((e) => ClassroomModel.fromJson(e))).toList();
        if (data.isNotEmpty) {
          classrooms.value = data;
        }
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  viewClassDetail(dynamic classroom) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    Get.off(() => ViewDetailClass(
          classroom: classroom,
          token: token,
        ));
  }

  deleteClass(dynamic classroom) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    try {
      var response = await http.delete(
        Uri.parse('http://localhost:3001/v1/classrooms/${classroom.id}'),
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Deleted class ${classroom.title}");
        print("Delete classrooms successfully");
        getClassrooms();
      } else {
        print("Error!");
      }
    } catch (e) {
      print(e);
    }
  }
}
