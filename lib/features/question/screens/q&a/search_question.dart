import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/class_controller.dart';
import 'package:blended_learning_appmb/features/question/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/question/question_card.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/class_model.dart';

class SearchQuestionScreen extends StatelessWidget {
  const SearchQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchQuestionController());
    final classController = ClassController.instance;
    return Scaffold(
      appBar: LAppBar(title: Text("Search Question"), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: LSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: searchController.keyword,
              decoration: const InputDecoration(labelText: "Keyword"),
            ),

            const SizedBox(
              height: LSizes.spaceBtwInputFields,
            ),
            DropdownButtonFormField<ClassModel>(
              decoration: const InputDecoration(labelText: "Class"),
              items: classController.allClasses
                  .map((course) => DropdownMenuItem<ClassModel>(
                  value: course, child: Text(course.title ?? "", style: Theme.of(context).textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis,)))
                  .toList(),
              onChanged: (course) {
                searchController.setClassSelected(course!);
                searchController.getSearchQuestion();
              },
              value: classController.allClasses[0],),
            const SizedBox(
              height: LSizes.spaceBtwInputFields,
            ),

            Obx(
                () => FutureBuilder(
                  key: Key(searchController.refreshData.value.toString()),
                  future: searchController.getSearchQuestion(), builder: (context, snapshot){
                final widget = LCloudHelperFunctions.checkSingleRecordState(snapshot);
                if(widget != null) return widget;
                // Data found
              
                final questions = snapshot.data;
                return ListView.builder(
                  itemCount: questions?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    //
              
              
                    // return Text("đây là 1 câu hỏi");
              
                    return LQuestionCard(question: questions![index],);
              
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
