import 'package:blended_learning_appmb/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:blended_learning_appmb/navigation_menu.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LLoginForm extends StatelessWidget {
  const LLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: LSizes.spaceBtwSections),
      child: Column(
        children: [
          // Email
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: LTexts.email),
          ),
          const SizedBox(
            height: LSizes.spaceBtwInputFields,
          ),

          // Password
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: LTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: LSizes.spaceBtwInputFields / 2,
          ),

          // Remember Me & Forget Password
          Row(
            children: [
              // Remember Me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(LTexts.rememberMe),
                ],
              ),

              // Forget Password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(LTexts.forgetPassword)),
            ],
          ),
          const SizedBox(
            height: LSizes.spaceBtwSections,
          ),

          // Sign In Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()),
                  child: const Text(LTexts.signIn))),
          const SizedBox(
            height: LSizes.spaceBtwSections,
          ),
        ],
      ),
    ));
  }
}
