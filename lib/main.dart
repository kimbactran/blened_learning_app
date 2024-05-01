import 'package:blended_learning_appmb/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Add Widget Binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // Get Local Storage
  await GetStorage.init();
  runApp(const MyApp());
}
