import 'package:blended_learning_appmb/utils/theme/custome_themes/appbar_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/bottom_sheet_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/checkbox_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/chip_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/elevated_button_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/outlined_button_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/text_field_theme.dart';
import 'package:blended_learning_appmb/utils/theme/custome_themes/text_theme.dart';
import 'package:flutter/material.dart';

class LAppTheme {
  LAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: LTextTheme.lightTextTheme,
    chipTheme: LChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: LAppBarTheme.lightAppBarTheme,
    checkboxTheme: LCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: LBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: LElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: LOutlinedButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: LTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: LTextTheme.darkTextTheme,
    chipTheme: LChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: LAppBarTheme.darkAppBarTheme,
    checkboxTheme: LCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: LBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: LElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: LOutlinedButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: LTextFieldTheme.darkInputDecorationTheme,
  );
}
