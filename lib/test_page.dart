import 'package:blended_learning_appmb/features/admin/controllers/classrooms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestApp extends StatelessWidget {
  ClassroomsController classroomsController = Get.put(ClassroomsController());
  String groupValue = "ACTIVE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Class Manager"),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Color.fromRGBO(61, 0, 153, 1),
        ),
        body: Obx(
          () => classroomsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: classroomsController.classrooms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("# ${index}"),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(61, 0, 153, 1)),
                                child: Text(
                                    "${classroomsController.classrooms[index].status}"),
                              ),
                              IconButton(
                                  onPressed: () => () => {},
                                  // handleViewDetailClass(classrooms[index]),
                                  icon: Icon(Icons.remove_red_eye)),
                              IconButton(
                                  onPressed: () => {_dialogBuilder(context)},
                                  // handleEditClass(classrooms[index]),
                                  icon: Icon(Icons.mode_edit_outline)),
                              IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.delete)),
                            ]),
                            tileColor: const Color.fromRGBO(221, 214, 232, 1),
                          ),
                          ListTile(
                            leading: Text(
                                "ID: ${classroomsController.classrooms[index].id}"),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Text(
                                "Title: ${classroomsController.classrooms[index].title}"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ));
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create classroom'),
          content: const Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 18),
                // controller: loginController.emailController,
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
            ),
          ]),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
