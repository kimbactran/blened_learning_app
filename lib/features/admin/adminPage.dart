import 'package:blended_learning_appmb/features/admin/classManager.dart';
import 'package:blended_learning_appmb/features/admin/dashboardPage.dart';
import 'package:blended_learning_appmb/features/admin/profilePage.dart';
import 'package:blended_learning_appmb/features/admin/userManager.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "DashBoard"),
          NavigationDestination(icon: Icon(Icons.class_), label: "Classrooms"),
          NavigationDestination(
              icon: Icon(Icons.supervised_user_circle), label: "Users"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
        // backgroundColor: Color.fromRGBO(61, 0, 153, 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
      ),
      body: <Widget>[
        DashBoardPage(),
        ClassManagerPage(),
        UserManagerPage(),
        ProfilePage()
      ][currentPageIndex],
    );
  }
}
