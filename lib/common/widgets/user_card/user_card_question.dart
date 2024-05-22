import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';
import 'package:blended_learning_appmb/features/question/screens/user/user_detail.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/constants/enums.dart';

class LUserCardQuestion extends StatelessWidget {
  const LUserCardQuestion({super.key, required this.user, required this.time, required this.postId, this.onActionDelete, this.onActionEdit, this.onActionChat});
  final UserModel user;
  final String time;
  final String postId;
  final  Function()? onActionDelete;
  final  Function()? onActionEdit;
  final  Function()? onActionChat;


  @override
  Widget build(BuildContext context) {
    final deviceStorage = GetStorage();
    bool showPopUpMenu = user.id! == deviceStorage.read("User Id");
    return GestureDetector(
      onTap: () => Get.to(() => UserDetailScreen(user: user)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(LImages.logoWithoutText),
                  ),
                  const SizedBox(
                    width: LSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.nameAndRole,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timeago.format(DateTime.parse(time), locale: 'en'),
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                ],
              ),
              if (showPopUpMenu)
              PopupMenuButton<MenuOption>(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) {

                    return <PopupMenuEntry<MenuOption>>[
                      const PopupMenuItem<MenuOption>(
                        value: MenuOption.delete,
                        child: Text('Delete'),
                      ),
                      const PopupMenuItem<MenuOption>(
                        value: MenuOption.edit,
                        child: Text('Edit'),
                      ),
                    ];

                },
                onSelected: (MenuOption result) {
                  if (result == MenuOption.delete) {
                    onActionDelete?.call();
                  } else if (result == MenuOption.edit) {
                    onActionEdit?.call();
                  }
                },
              ),
            ],
          ),

          const SizedBox(
            height: LSizes.spaceBtwItems,
          ),

          /// Review
        ],
      ),
    );
  }
}
