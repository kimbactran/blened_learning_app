import 'dart:convert';

import 'package:blended_learning_appmb/features/admin/adminPage.dart';
import 'package:blended_learning_appmb/features/student/studentPage.dart';
import 'package:blended_learning_appmb/features/teacher/teacherPage.dart';
import 'package:blended_learning_appmb/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      };
      var url = Uri.parse(LApi.baseUrl + LApi.authApi.loginAuth);
      Map body = {
        'email': emailController.text.trim().toString(),
        'password': passwordController.text.toString(),
      };
      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body.toString());
        var token = json['token']['accessToken'];
        final SharedPreferences? prefs = await _prefs;

        await prefs?.setString('token', token);
        emailController.clear();
        passwordController.clear();
        if (json['user']['role'] == 'ADMIN') {
          Get.off(const AdminPage());
        } else if (json['user']['role'] == 'TEACHER') {
          Get.off(const TeacherPage());
        } else if (json['user']['role'] == 'STUDENT') {
          Get.off(const StudentPage());
        } else
          print("Unable to determine the logged in user's role!");
        print('Login successfully');
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
