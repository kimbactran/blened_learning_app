import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// Function to request storage permission
Future<void> requestStoragePermission() async {
  final PermissionStatus status = await Permission.storage.request();
  if(status.isDenied) {
    print('Storage permission denied');
  } else if (status.isPermanentlyDenied){
    print('Storage permission permanently denied');
    openAppSettings();
  }
}