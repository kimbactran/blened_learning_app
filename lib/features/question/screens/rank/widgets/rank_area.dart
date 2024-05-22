import 'package:blended_learning_appmb/common/widgets/user_card/user_card.dart';
import 'package:blended_learning_appmb/features/question/screens/rank/widgets/rank_user_st1.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/user_attribute.dart';

class RankArea extends StatelessWidget {
  const RankArea({super.key, required this.userAttributes});
  final List<UserAttributeModel> userAttributes;

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: LSizes.spaceBtwItems,),
            if(userAttributes.isEmpty)
            const Center(child: Text('Class has no action!'),),
            ListView.builder(
              shrinkWrap: true,
                itemCount: userAttributes.length,
                itemBuilder: (_, index) {
              final int point = userAttributes[index].numAnswer! + userAttributes[index].numQuestion! + userAttributes[index].numLike!;
              if(index == 0) return RankUserCardOne(user: userAttributes[index],);
              return Padding(
                padding: const EdgeInsets.all(LSizes.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${index + 1}'),
                    Expanded(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: LUserCard(user: userAttributes[index].user!)),
                            Text('${point.toString()} point'),
                          ],
                        ),
                    )
                  ],
                ),
              );
            })
          ],
        
            ),
      );
  }
}
