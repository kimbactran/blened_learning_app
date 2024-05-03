import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/image/circular_image.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
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
    final authenticationRepository = AuthenticationRepository.instance;
    final _user = authenticationRepository.user;
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
              value: _user.name??"",
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Role',
              value: _user.role??"STUDENT",
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
              value: _user.id??"",
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'E-mail',
              value: _user.email??"",
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),

            LProfileMenu(
              title: 'Gender',
              value: _user.gender??"",
              onPressed: () {},
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            /*
            const Divider(),
            Center(
                child: TextButton(
              onPressed: () {},
              child: Text('Close Account',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: LColors.error)),
            )),*/
          ]),

          // Details
        ),
      ),
    );
  }
}
