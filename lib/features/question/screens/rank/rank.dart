import 'package:blended_learning_appmb/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppBar(
        title: Center(
            child:
                Text('Rank', style: Theme.of(context).textTheme.headlineSmall)),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
