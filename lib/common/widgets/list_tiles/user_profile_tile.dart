import 'package:blended_learning_appmb/common/widgets/image/circular_image.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:blended_learning_appmb/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LUserProfileTile extends StatelessWidget {
  const LUserProfileTile({
    super.key,
    this.title,
    this.subTitle,
    this.imageUrl,
    this.onPressed,
  });

  final String? title, subTitle;
  final String? imageUrl;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const LCircularImage(
        imageUrl: LImages.logoWithoutText,
        width: 50,
        height: 50,
      ),
      title: Text(
        'Kiba Trn',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: LColors.white),
      ),
      subtitle: Text(
        'kimbactrancutebaby@gmail.com',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: LColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: LColors.white,
          )),
    );
  }
}
