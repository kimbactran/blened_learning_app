import 'package:blended_learning_appmb/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /// Headings
            Text(
              LTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            Text(
              LTexts.forgetPasswordSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: LSizes.spaceBtwSections * 2,
            ),

            /// Text field
            TextFormField(
              decoration: const InputDecoration(
                  labelText: LTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right)),
            ),

            /// Submit Button
            const SizedBox(
              height: LSizes.spaceBtwSections,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const ResetPassword()),
                  child: const Text(LTexts.submit),
                ))
          ]),
        ),
      ),
    );
  }
}
