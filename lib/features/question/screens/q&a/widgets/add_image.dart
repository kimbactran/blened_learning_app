import 'package:blended_learning_appmb/features/question/controllers/add_question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    final addQuestionController = AddQuestionController.instance;
    return Column(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addQuestionController.chooseImage();
            },
          ),
        ),
        Obx(() {
          if (addQuestionController.images.isEmpty) {
            return const Center(
              child: Text('No Image Selected'),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Image(
                  image: NetworkImage(addQuestionController.images[index]));
            },
            itemCount: addQuestionController.images.length,
          );
        })
      ],
    );
    /*Container(
          width: LHelperFunctions.screenWidth() - 10,
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: addQuestionController.images.length + 1,
              itemBuilder: (context, index) {
                if(addQuestionController.images.isEmpty) {
                  return Center(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addQuestionController.chooseImage();
                      },
                    ),
                  );
                }
          return index == 0
              ? Center(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                addQuestionController.chooseImage();
              },
            ),
          )
              : Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(addQuestionController.images[index - 1]), fit: BoxFit.cover)
            )
          );
            }),
        ),*/
  }
}
