import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../features/personalization/models/user_model.dart';

class LUserCard extends StatelessWidget {
  const LUserCard({super.key, required this.user, this.onPressed});
  final UserModel user;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(LImages.logoWithoutText),
              ),
              const SizedBox(
                width: LSizes.spaceBtwItems,
              ),
              Expanded(
                child: Text(
                  user.nameAndRole,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          /// Review
        ));
  }
}
