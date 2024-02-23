import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewDetailClass extends StatefulWidget {
  final dynamic classroom;
  final String? token;
  const ViewDetailClass(
      {required this.classroom, required this.token, super.key});

  @override
  State<ViewDetailClass> createState() => _ViewDetailClassState();
}

class _ViewDetailClassState extends State<ViewDetailClass> {
  Future<dynamic> getClassroom() async {
    print('http://localhost:3001/v1/classrooms/${widget.classroom['id']}');
    try {
      var response = await http.get(
          Uri.parse(
              'http://localhost:3001/v1/classrooms/${widget.classroom['id']}'),
          headers: {
            "Authorization": "Bearer ${widget.token}",
          });
      if (response.statusCode == 200) {
        print("Get classrooms data successfully!");
        return jsonDecode(response.body.toString());
      } else {
        print("Can't not get data!");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> getUserInClassroom() async {
    try {
      var response = await http.get(
          Uri.parse(
              'http://localhost:3001/v1/users/users-by-classroom/${widget.classroom['id']}'),
          headers: {
            "Authorization": "Bearer ${widget.token}",
          });
      if (response.statusCode == 200) {
        print("Get classrooms data successfully!");
        return jsonDecode(response.body.toString());
      } else {
        print("Can't not get data!");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  void handleDeleteUserInClass(String userID) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://localhost:3001/v1/users/remove-classroom-from-user'),
          headers: {
            "Authorization": "Bearer ${widget.token}",
          },
          body: {
            "userId": userID,
            "classroomId": widget.classroom['id']
          });
      if (response.statusCode == 200) {
        print("Remove user from class successfully!");
        getUserInClassroom();
      } else {
        print("Error.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Information'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Add User"),
        icon: const Icon(Icons.add),
        foregroundColor: const Color.fromRGBO(61, 0, 153, 1),
      ),
      body: FutureBuilder<dynamic>(
        future: getClassroom(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Can't not get data!"));
          } else {
            dynamic classroom = {}; // Var classrooms ở cấp độ lớp
            classroom = snapshot.data!;
            return Column(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Text("ID: ${classroom["id"]}"),
                    ),
                    ListTile(
                      leading: Text("Title: ${classroom["title"]}"),
                    ),
                    ListTile(
                      leading: Text("Status: ${classroom["status"]}"),
                    ),
                  ],
                ),
                const Text(
                  "List Users in Classroom",
                  style: TextStyle(),
                ),
                Expanded(
                  child: FutureBuilder<dynamic>(
                    future: getUserInClassroom(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Can't not get data!"));
                      } else {
                        dynamic usersInClassrooms =
                            {}; //Var classrooms ở cấp độ lớp
                        usersInClassrooms = snapshot.data!;
                        return ListView.builder(
                          // shrinkWrap: true,
                          itemCount: usersInClassrooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Text("# ${index}"),
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  handleDeleteUserInClass(
                                                      usersInClassrooms[index]
                                                          ["id"]),
                                              icon: const Icon(Icons.delete)),
                                        ]),
                                    tileColor:
                                        const Color.fromRGBO(221, 214, 232, 1),
                                  ),
                                  ListTile(
                                    leading: Text(
                                        "ID: ${usersInClassrooms[index]["id"]}"),
                                  ),
                                  ListTile(
                                    leading: Text(
                                        "Title: ${usersInClassrooms[index]["email"]}"),
                                  ),
                                  ListTile(
                                    leading: Text(
                                        "ID: ${usersInClassrooms[index]["name"]}"),
                                  ),
                                  ListTile(
                                    leading: Text(
                                        "Title: ${usersInClassrooms[index]["gender"]}"),
                                  ),
                                  ListTile(
                                    leading: Text(
                                        "ID: ${usersInClassrooms[index]["role"]}"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
