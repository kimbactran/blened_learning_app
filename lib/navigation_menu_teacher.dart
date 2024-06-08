import 'package:blended_learning_appmb/features/personalization/screens/screens/settings/settings.dart';
import 'package:blended_learning_appmb/features/question/screens/classes/classes.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/question.dart';
import 'package:blended_learning_appmb/features/question/screens/report/report.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/question/screens/chat/chat.dart';

class NavigationTeacherMenu extends StatelessWidget {
  const NavigationTeacherMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = LHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? LColors.black : LColors.white,
            indicatorColor: darkMode
                ? LColors.white.withOpacity(0.1)
                : LColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Iconsax.message_question), label: 'Q&A'),
              NavigationDestination(icon: Icon(Iconsax.book), label: 'Classes'),
              NavigationDestination(
                  icon: Icon(Iconsax.diagram), label: 'Report'),
              NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const QuestionScreen(),
    const ClassesScreen(),
    const ReportScreen(),
    const ChatScreen(),
    const SettingsScreen()
  ];
}
