import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/rank_controller.dart';
import 'package:blended_learning_appmb/features/question/screens/rank/widgets/rank_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rankController = Get.put(RankController());
    return Obx(
      () {
        if(rankController.allClasses.isEmpty) {
          return Center(child: Text("No class found!"),);
        }
        return DefaultTabController(
        length: rankController.allClasses.length ,
        child: Scaffold(
          appBar: LAppBar(
            title: Center(
                child:
                    Text('Rank', style: Theme.of(context).textTheme.headlineSmall)),
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      /// Tabs
                      title:  EcoTabBar(
                          tabs: rankController.allClasses
                              .map((course) => Tab(
                            child: SizedBox(
                              width: 100,
                                child: Text(course.title!,)),
                          ))
                              .toList()))
                ];
              },
              body: TabBarView(
                  children:
                    rankController.allClasses.map((course) =>
                    FutureBuilder(
                        future: rankController.getAttributeOfUser(course.id!),
                        builder: (context, snapshot) {
                          final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                          if(widget != null) return widget;

                          final users = snapshot.data;
                          return
                            RankArea(userAttributes: users!,);
                        })).toList()

              )
          ),

        ),
      );},
    );
  }
}
