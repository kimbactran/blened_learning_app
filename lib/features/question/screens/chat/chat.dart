import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:blended_learning_appmb/data/repositories/chat/chat_repository.dart';
import 'package:blended_learning_appmb/features/question/controllers/chat_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/chat/widgets/chats.dart';
import 'package:blended_learning_appmb/features/question/screens/user/search_user.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/list_tiles/user_message_tile.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../user/list_user_class.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRepository = Get.put(ChatRepository());
    final authenticationRepository = AuthenticationRepository.instance;
    return Scaffold(
        appBar: LAppBar(
          title:
              Text('Chats', style: Theme.of(context).textTheme.headlineSmall),
          actions: [
            LCircularIcon(
              icon: Iconsax.notification,
              onPressed: () {},
            ),
            LCircularIcon(
              icon: Iconsax.search_normal,
              onPressed: () => Get.to(() =>const SearchUserScreen()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child:
              Padding(
                padding: const EdgeInsets.all(LSizes.sm),
                child: FutureBuilder(
                  future: chatRepository
                      .getListUser(authenticationRepository.user.id!),
                  builder: (context, snapshot) {
                    final widget =
                        LCloudHelperFunctions.checkSingleRecordState(snapshot);
                    if (widget != null) return widget;
                    // Data found
                    final users = snapshot.data;
                    if (users!.isEmpty) {
                      return const Center(
                        child: Text('No user '),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return LUserCard(user: users[index], onPressed: () => Get.to(() => ChatWithUser(receiver: users[index],)),);
                      },
                      itemCount: users.length,
                    );
                  },
                ),
              )

        )
        );
  }
}
