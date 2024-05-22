import 'package:blended_learning_appmb/features/question/models/user_attribute.dart';
import 'package:blended_learning_appmb/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class RankUserCardOne extends StatelessWidget {
  const RankUserCardOne({super.key, required this.user});
  final UserAttributeModel user;

  @override
  Widget build(BuildContext context) {
    final int point = user.numAnswer! + user.numQuestion! + user.numLike!;
    return Column(
      children: [
            const LCircularContainer(
              backgroundColor: LColors.primary1,
              height: 100,
              width: 100,
              child: Image( image: AssetImage(LImages.logoWithoutText),),
            ),

        Text(user.user!.name!),
        Text('${point.toString()} point'),
        const Divider(),
        const SizedBox(height: LSizes.spaceBtwItems,),

      ],
    );
  }
}
