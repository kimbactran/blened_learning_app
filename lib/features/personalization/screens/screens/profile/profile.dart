import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/image/circular_image.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/features/personalization/screens/screens/profile/widgets/profile_menu.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = LHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const LAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.defaultSpace),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Column(children: [
                // Profile Picture
                LCircularImage(
                  backgroundColor: darkMode ? LColors.light : LColors.darkGrey,
                  imageUrl: LImages.logoWithoutText,
                  width: 80,
                  height: 80,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text('Change Profile Picture'))
              ]),
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems / 2,
            ),
            const Divider(),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            const LSectionHeading(
              title: 'Profile Infomation',
              showActionButton: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Name',
              value: 'Kiba Trn',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Username',
              value: 'kiba_trn',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            const Divider(),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            const LSectionHeading(
              title: 'Personal Infomation',
              showActionButton: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'User ID',
              value: '048474',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'E-mail',
              value: 'kimbactrancutebaby@gmail.com',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Phone Number',
              value: '0399523244',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Gender',
              value: 'Female',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Date of Birth',
              value: '5 Oct, 2002',
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            const Divider(),
            Center(
                child: TextButton(
              onPressed: () {},
              child: Text('Close Account',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: LColors.error)),
            )),
          ]),

          // Details
        ),
      ),
    );
  }
}
