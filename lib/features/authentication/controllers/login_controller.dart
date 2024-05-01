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
      deviceStorage.write('Role', authenticationRepository.user.role);

      final role = authenticationRepository.user.role;
      LFullScreenLoader.stopLoading();
      if (role == 'ADMIN') {
        Get.off(() => const AdminPage());
      } else if (role == 'TEACHER') {
        Get.off(() => const TeacherPage());
      } else if (role == 'STUDENT') {
        Get.off(() => const NavigationMenu());
      } else {
        LLoader.errorSnackBar(
            title: 'Oh Snap!',
            message: "Unable to determine the logged in user's role!");
      }

      LLoader.successSnackBar(
          title: 'Login Successfully!', message: 'You are logged in as $role');

    } catch (error) {
      LFullScreenLoader.stopLoading();

      // Show some one Generic Error to the user
      LLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}
