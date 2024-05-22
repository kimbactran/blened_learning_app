import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/user_card/user_card.dart';
import '../../controllers/search_user_controller.dart';
import '../chat/widgets/chats.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchUserController = Get.put(SearchUserController());
    return Scaffold(
      appBar: LAppBar(title: Text("Search User"), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      controller: searchUserController.keyword,
                      decoration: const InputDecoration(labelText: "User Name"),
                    ),
                  ),
                  const SizedBox(
                    width: LSizes.sm,
                  ),
                  ElevatedButton(
                      onPressed: () => searchUserController.searchUser(),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('Search'),
                      ))
                ],
              ),
              const SizedBox(height: LSizes.spaceBtwItems,),
              Obx(() {
                if(searchUserController.userFilter.isEmpty) {
                  return const Center(child: Text('No user found!'),);
                }
                return ListView.builder(itemBuilder: (_, index){
                  final user = searchUserController.userFilter[index];
                   return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: LUserCard(user: user)),
                      IconButton(
                        icon: const Icon(Iconsax.message),
                        onPressed: () => Get.to(() => ChatWithUser(
                          receiver: user,
                        )),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: searchUserController.userFilter.length,);
              })
            ],
          ),
        ),
      ),
    );
  }
}
