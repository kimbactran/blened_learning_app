import 'package:blended_learning_appmb/features/authentication/screens/login/login.dart';
import 'package:blended_learning_appmb/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const LoginScreen(),
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: LAppTheme.lightTheme,
      darkTheme: LAppTheme.darkTheme,
    );
  }
}
