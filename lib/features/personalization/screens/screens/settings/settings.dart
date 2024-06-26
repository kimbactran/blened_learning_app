import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:blended_learning_appmb/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:blended_learning_appmb/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:blended_learning_appmb/common/widgets/texts/section_heading.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:blended_learning_appmb/features/personalization/screens/screens/profile/profile.dart';
import 'package:blended_learning_appmb/features/question/screens/answers/answer_user.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/widgets/list_question.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../authentication/screens/login/login.dart';
import '../../../../question/controllers/question_controller.dart';
import '../../../../question/screens/tag/tag_user.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final authenticationRepository = AuthenticationRepository.instance;
    final questionController = QuestionController.instance;
    final _user = authenticationRepository.user;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// - Header
            LPrimaryHeaderContainer(
                child: Column(
              children: [
                LAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: LColors.white),
                  ),
                ),

                /// User Profile card
                LUserProfileTile(
                  user: _user,
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: LSizes.spaceBtwSections,
                ),
              ],
            )),
            //// --- Body
            Padding(
              padding: const EdgeInsets.all(LSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Sections
                  const LSectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: LSizes.spaceBtwItems,
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.medal,
                    title: 'My Point',
                    subTitle: 'Perform missions and improve your score',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.message_question,
                    title: 'My Question',
                    subTitle: 'Ask questions to improve your score',
                    onTap: () => Get.to(() =>  ListQuestion(title: "My Questions",getData: questionController.getQuestionOfUser(),)),
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Answer',
                    subTitle: 'Your answers are very helpful in teaching',
                    onTap: () => Get.to(() => const AnswerOfUserScreen()),
                  ),

                  LSettingsMenuTile(
                    icon: Iconsax.hashtag,
                    title: 'All Tags',
                    subTitle: 'Explore hashtags',
                    onTap: () => Get.to(() => const TagOfUserScreen()),
                  ),

                  LSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notification',
                    subTitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  /// -- App Settings
                  const LSectionHeading(
                    title: 'App Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: LSizes.spaceBtwItems,
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Location',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: LColors.primary,
                      inactiveTrackColor: LColors.primary.withOpacity(0.6),
                    ),
                  ),

                  LSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(
                        value: true,
                        activeColor: LColors.primary,
                        inactiveTrackColor: LColors.primary.withOpacity(0.6),
                        onChanged: (value) {}),
                  ),

                  /// Logout Button
                  const SizedBox(
                    height: LSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      child: const Text('Logout'),
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                    ),
                  ),
                  const SizedBox(
                    height: LSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
