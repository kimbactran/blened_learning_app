import 'package:blended_learning_appmb/features/authentication/controllers/login_controller.dart';
import 'package:blended_learning_appmb/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/constants/text_string.dart';
import 'package:blended_learning_appmb/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LLoginForm extends StatelessWidget {
  const LLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Obx(
      () => Form(
          key: loginController.loginFormKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: LSizes.spaceBtwSections),
            child: Column(
              children: [
                // Email
                TextFormField(
                  controller: loginController.email,
                  validator: (value) => LValidator.validateEmail(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: LTexts.email),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwInputFields,
                ),

                // Password
                TextFormField(
                  controller: loginController.password,
                  validator: (value) => LValidator.validatePassword(value),
                  obscureText: loginController.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: LTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () => loginController.hidePassword.value =
                              !loginController.hidePassword.value,
                          icon: Icon(loginController.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye))),
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
                        onPressed: () => loginController.login(),
                        // onPressed: () => Get.to(() => const NavigationMenu()),
                        child: const Text(LTexts.signIn))),
                const SizedBox(
                  height: LSizes.spaceBtwSections,
                ),
              ],
            ),
          )),
    );
  }
}
