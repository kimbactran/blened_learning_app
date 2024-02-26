import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:blended_learning_appmb/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:blended_learning_appmb/features/question/screens/q&a/widgets/question_item.dart';
import 'package:blended_learning_appmb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class ClassDetailScreen extends StatelessWidget {
  const ClassDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppBar(
        title: Text("Class Details",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LQuestionItem(
              showBorder: true,
            ),
            Padding(
              padding: const EdgeInsets.all(LSizes.sm),
              child: LRoundedContainer(
                showBorder: true,
                child: TreeView(nodes: [
                  TreeNode(
                    content: const Expanded(
                      child: Text("Giáo trình"),
                    ),

                    // LSyllabusItem(
                    //   title: "Giáo trình",
                    //   countQuestion: '2',
                    // ),
                    children: [
                      TreeNode(
                          content: const Expanded(
                            child: Text(
                                "Chương 1: Các khái niệm cơ bản về xác suất"),
                          ),
                          children: [
                            TreeNode(
                                content: const Expanded(
                                    child: Text(
                                        "1.1 Phép thử ngẫu nhiên và không gian mẫu"))),
                            TreeNode(
                                content: const Expanded(
                                    child: Text(
                                        "1.2 Biến cố và quan hệ giữa các biến cố"))),
                            TreeNode(
                                content: const Expanded(
                                    child: Text(
                                        "1.3 Xác suất của biến cố và các quy tắc tính xác suất cơ bản"))),
                            TreeNode(
                                content: const Expanded(
                                    child: Text("1.4 Xác suất có điều kiện"))),
                            TreeNode(
                                content: const Expanded(
                                    child: Text(
                                        "1.5 Công thức xác suất đầy đủ và công thức Bayes"))),
                            TreeNode(
                                content: const Expanded(
                                    child: Text(
                                        "1.6 Phép thử lặp và công thức Bernoulli"))),
                          ])
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
