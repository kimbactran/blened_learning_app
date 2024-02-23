import 'package:flutter/material.dart';

class UserManagerPage extends StatefulWidget {
  const UserManagerPage({Key? key}) : super(key: key);

  @override
  _UserManagerPageState createState() => _UserManagerPageState();
}

class _UserManagerPageState extends State<UserManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UserManager Page")),
    );
  }
}
