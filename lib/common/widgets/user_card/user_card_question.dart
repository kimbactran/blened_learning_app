import 'package:blended_learning_appmb/features/personalization/models/user_model.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:blended_learning_appmb/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LUserCardQuestion extends StatelessWidget {
  const LUserCardQuestion({super.key, required this.user, required this.time});
  final UserModel user;
  final String time;

  @override
  Widget build(BuildContext context) {
    final darkMode = LHelperFunctions.isDarkMode(context);
    return Column(
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
                  children: [
                    Text(
                      user.nameAndRole,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      timeago.format(DateTime.parse(time), locale: 'en'),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),

        const SizedBox(
          height: LSizes.spaceBtwItems,
        ),

        /// Review
      ],
    );
  }
}
