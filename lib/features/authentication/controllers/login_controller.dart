import 'package:blended_learning_appmb/common/widgets/loaders/loaders.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:blended_learning_appmb/features/admin/adminPage.dart';
import 'package:blended_learning_appmb/features/teacher/teacherPage.dart';
import 'package:blended_learning_appmb/navigation_menu.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variable
  final authenticationRepository = Get.put(AuthenticationRepository());

  final hidePassword = true.obs;
  final deviceStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
          'We are processing your information...', LImages.loaderAnimation);
      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();

      // if (!isConnected) {
      //   return;
      // }
      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      // Call API login
      await authenticationRepository.login(
          email.text.trim().toString(), password.text.trim().toString());
      deviceStorage.write('Token', authenticationRepository.token.accessToken);
      deviceStorage.write('User Id', authenticationRepository.user.id);
      final role = authenticationRepository.user.role;
      if (role == 'ADMIN') {
        Get.off(const AdminPage());
      } else if (role == 'TEACHER') {
        Get.off(const TeacherPage());
      } else if (role == 'STUDENT') {
        Get.to(() => const NavigationMenu());
      } else {
        LLoader.errorSnackBar(
            title: 'Oh Snap!',
            message: "Unable to determine the logged in user's role!");
      }
      LLoader.successSnackBar(
          title: 'Login Successfully!', message: 'You are logged in as $role');
      // var headers = {
      //   "Access-Control-Allow-Origin": "*",
      //   'Content-Type': 'application/json',
      //   'Accept': '*/*'
      // };
      // var url = Uri.parse('http://192.168.2.110:3001/v1/auth/login');
      // Map body = {
      //   'email': email.text.trim().toString(),
      //   'password': password.text.toString(),
      // };
      // var response = await http.post(url, body: {
      //   'email': email.text.trim().toString(),
      //   'password': password.text.toString(),
      // });

      // if (response.statusCode == 200) {
      //   final json = jsonDecode(response.body.toString());
      //   var token = json['token']['accessToken'];
      //   var userId = json['user']['id'];
      //   deviceStorage.write('Token', token);
      //   deviceStorage.write('User Id', userId);

      //   final SharedPreferences? prefs = await _prefs;

      //   await prefs?.setString('token', token);
      //   await prefs?.setString('userId', userId);
      //   email.clear();
      //   email.clear();
      //   final role = json['user']['role'];
      //   if (json['user']['role'] == 'ADMIN') {
      //     Get.off(const AdminPage());
      //   } else if (json['user']['role'] == 'TEACHER') {
      //     Get.off(const TeacherPage());
      //   } else if (json['user']['role'] == 'STUDENT') {
      //     Get.to(() => const NavigationMenu());
      //   } else {
      //     LLoader.errorSnackBar(
      //         title: 'Oh Snap!',
      //         message: "Unable to determine the logged in user's role!");
      //   }
      //   LLoader.successSnackBar(
      //       title: 'Login Successfully!',
      //       message: 'You are logged in as $role');
      // } else {
      //   throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      // }
    } catch (error) {
      // Show some one Generic Error to the user
      print(error);
      LLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}
