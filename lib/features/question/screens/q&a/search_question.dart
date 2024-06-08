import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/features/question/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/question/question_card.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/class_model.dart';

class SearchQuestionScreen extends StatelessWidget {
  const SearchQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchQuestionController());
    //searchController.classSelected.value = classController.allClasses[0];

    return Scaffold(
      appBar: const LAppBar(
        title: Text("Search Question"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.sm),
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
              Obx(
                () => DropdownButtonFormField<ClassModel>(
                  decoration: const InputDecoration(
                      labelText: "Class", hintText: "Select class"),
                  items: searchController.allClasses
                      .map((course) => DropdownMenuItem<ClassModel>(
                          value: course,
                          child: Text(
                            course.title ?? "",
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )))
                      .toList(),
                  onChanged: (course) {
                    searchController.setClassSelected(course!);
                  },
                  value: searchController.classSelected.value,
                ),
              ),
              const SizedBox(
                height: LSizes.spaceBtwInputFields,
              ),
              ElevatedButton(
                onPressed: () => searchController.onSearchBtn(),
                child: const Text("Search"),
              ),
              const SizedBox(
                height: LSizes.spaceBtwInputFields,
              ),
              Obx(() {
                if (searchController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (searchController.questions.isEmpty) {
                  return const Center(child: Text("No question found!"));
                }
                return ListView.builder(
                  itemCount: searchController.questions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    //return Text("đây là 1 câu hỏi");
                    return LQuestionCard(
                      question: searchController.questions[index],
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
