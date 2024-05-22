import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../personalization/models/user_model.dart';
import '../../../personalization/screens/screens/profile/widgets/profile_menu.dart';
import '../chat/widgets/chats.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final authenticationRepository = AuthenticationRepository.instance;
    return Scaffold(
      appBar: LAppBar(
        title: Text("User Infomation"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(LSizes.sm),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(LSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: LUserCard(user: user)),
                  IconButton(
                    icon: Icon(Iconsax.message),
                    onPressed: () => Get.to(() => ChatWithUser(
                          receiver: user,
                        )),
                  ),
                ],
              ),
            ),
            const Divider(),
            const LSectionHeading(
              title: 'Profile Infomation',
              showActionButton: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Name',
              value: user.name ?? "Aynomous user",
              onPressed: () {},
              showIcon: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Role',
              value: user.role ?? "STUDENT",
              onPressed: () {},
              showIcon: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'E-mail',
              value: user.email ?? "",
              onPressed: () {},
              showIcon: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
            LProfileMenu(
              title: 'Gender',
              value: user.gender ?? "",
              onPressed: () {},
              showIcon: false,
            ),
            const SizedBox(
              height: LSizes.spaceBtwItems,
            ),
          ],
        ),
      )),
    );
  }
}
