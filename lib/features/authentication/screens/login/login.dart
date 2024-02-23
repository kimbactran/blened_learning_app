import 'package:blended_learning_appmb/common/styles/spacing_styles.dart';
import 'package:blended_learning_appmb/common/widgets/login_signup/form_divider.dart';
import 'package:blended_learning_appmb/features/authentication/screens/login/widgets/login_form.dart';
import 'package:blended_learning_appmb/features/authentication/screens/login/widgets/login_header.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/constants/text_string.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: LSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            // -- Header: Logo, Title & Sub-Title
            LLoginHeader(),
            // -- Form
            LLoginForm(),
          ],
        ),
      ),
    ));
  }
}
