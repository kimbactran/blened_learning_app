import 'dart:convert';
import 'package:blended_learning_appmb/features/admin/viewDetailClass.dart';
import 'package:blended_learning_appmb/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blended_learning_appmb/features/admin/controllers/classrooms_controller.dart';
import 'package:get/get.dart';

class ClassManagerPage extends StatefulWidget {
  const ClassManagerPage({Key? key}) : super(key: key);

  @override
  _ClassManagerPageState createState() => _ClassManagerPageState();
}

class _ClassManagerPageState extends State<ClassManagerPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<String> titles = <String>[
    "ID: ",
    "Title: ",
  ];

  // String token =
  //     "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRW1haWwiOiJhZG1pbkBnbWFpbC5jb20iLCJ0eXBlIjoiQUNDRVNTX1RPS0VOIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzA0OTkzOTk0fQ.NH8wd5oHAylPZlxL8_o4f9rHsLLEDPRA5aHMQxgkKKAaZr3FuxwBEcuc2kdSmsHLeFYWVhq2O3vZSZbvaiRMKIzGObhyibi1S87j_0WdHpMLhpYfH_rEDaZLEyo-EP8_UcI4sLihMLWWelOFwUqBRG0fFGgpKY-bkOf5yPwks0_O4_N9eAmHSZJaofxHN_2R3g89ckKWQ5aUQM3NdfQhNCNbRsJ3keuye3QJQ4LV57Fe5kPBWfH17sKRZ1KTj9iTtn6SINn3ai6lzJB7wgt7eL3wOH-w_hJxO-j97MSpvjRJn9G1jRmF6OpZ23BXHO7ChYSLCEh2XnNi8k1Euvrbew8KuJtt2dg3sBa8BGpXI2xw9Fyo8qJi0kcSE0cvOZlJNshUxDXml4aD0oDLxnqcJBC3cbgc82xB8Hy1SIOFtby_vRKc3TAL4eYVSdjIvBa9FljTFnX_HLPcJEepqy_C4qlhmBmtGjZBE_SV5R2qt5UNcppd5U_FVBwYBFbHQNH6lPqMHF-VRPS7ywNriUFOKphHOXiGwRrLzngDOD478AD2SHEJZXODH4bFCt7qONdRmMgUmKsySm_3KFcFYZ_bvwTTEkkKXoFlfOc7KWwT--T0OfazjLn9jA05o57TGqPm5_Qr6h12akCHalgb7pz0cszbMCPK8sLSKE3Ojb36xaU";
  List<dynamic> classrooms = []; // Biến classrooms ở cấp độ lớp
  Future<List<dynamic>> getClassrooms() async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    // String token =
    //     'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRW1haWwiOiJhZG1pbkBnbWFpbC5jb20iLCJ0eXBlIjoiQUNDRVNTX1RPS0VOIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzA1MDcwMTY0fQ.JV_cgBz4dyFxRwGyQmBlospcHT9lcUWxL9JwNOShWCQSdeQf_XJG1q33KQlV18Gz9xK_gkFuHgFlpyf6xbDU_qljtG9hgZzJ0Zxhqis1QaO87UmmpBH1qi8_BuGNi_kSfMVmXkvSCLmHG_D4qMXNSu--xRIP6lo6lN0F7yHR_9QGW_skddO2rMGzxY05sF245-obAIzS22OaAHbyjvln6EeOFQbd1dCx73B9OAziyfTdi077L4jSo9KTYoh_pNMzix7qWwmn1anciJXd-DSp6dKkZfPjwfenFO4xWsR29eLyBrL7L_qz0i-LfyAi9z9P0bdZhNLa5RKaYE4lfxSwbLAfbq2kE1wl2D4EmMVy8nPRMFI09p-CBj2XSyzgkzWtBgGGNwB41Q7f9eqDHIDGJ4mBBZltJ5EK8q4TFfSbrDY-IMdGvDh3oSC_T_Jwx_fPgmrmE96wcZxsVCJuqE4liflT38tGvXM28wmMf1vYiK0G6_r0Nqwd-2mKXa_tpk3DguWibBk-_sXmZSsaur6bzs-wZgJWwtcBcL8jZ271njpxHiGAHitmFVguZvlzmAGb3k-29EUkFrR8VM8-XMkwcAinIFdD3qUnyTVLW8bZce233gKnZFGUJC_ewXJsf_RNqivorfEp8S1Qja_q7Jpps51ZHM-r-_6xVFRxXmGYmls';
    try {
      var url = Uri.parse(LApi.baseUrl + LApi.classroomApi.classroom);
      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${token}",
      });
      if (response.statusCode == 200) {
        print("Lấy dữ liệu danh sách lớp học thành công");
        return jsonDecode(response.body.toString());
      } else {
        print("Không thể lấy dữ liệu");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  ClassroomsController classroomsController = Get.put(ClassroomsController());

  @override
  Widget build(BuildContext context) {
    getClassrooms();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Manager"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: const Color.fromRGBO(61, 0, 153, 1),
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
                                      const Color.fromRGBO(61, 0, 153, 1)),
                              child: Text(
                                  "${classroomsController.classrooms[index].status}"),
                            ),
                            IconButton(
                                onPressed: () async {
                                  final SharedPreferences? prefs = await _prefs;
                                  var token = prefs?.get('token').toString();
                                  Get.to(ViewDetailClass(
                                      classroom: classroomsController
                                          .classrooms[index],
                                      token: token));
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            IconButton(
                                onPressed: () {},
                                // handleEditClass(classrooms[index]),
                                icon: const Icon(Icons.mode_edit_outline)),
                            IconButton(
                                onPressed: () async {
                                  classroomsController.deleteClass(
                                      classroomsController.classrooms[index]);
                                },
                                icon: const Icon(Icons.delete)),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        label: const Text("Add Classroom"),
        icon: const Icon(Icons.add),
        foregroundColor: const Color.fromRGBO(61, 0, 153, 1),
      ),
    );
  }

  void handleCreateClass(dynamic classroomInfo) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    try {
      var response = await http
          .post(Uri.parse('http://localhost:3001/v1/classrooms'), headers: {
        "Authorization": "Bearer ${token}",
      }, body: {
        'title': classroomInfo.title,
        'resources': classroomInfo.status,
      });
      if (response.statusCode == 200) {
        print("Xóa lớp học thành công!");
        getClassrooms();
      } else {
        print("Đã có lỗi xảy ra");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleDeleteClass(String classroomId) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    try {
      var response = await http.delete(
        Uri.parse('http://localhost:3001/v1/classrooms/${classroomId}'),
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      if (response.statusCode == 200) {
        print("Xóa lớp học thành công!");
        getClassrooms();
      } else {
        print("Đã có lỗi xảy ra");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleViewDetailClass(dynamic classroom) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    // Get.off(ViewDetailClass(
    //   classroom: classroom,
    //   token: token,
    // ));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewDetailClass(
                  classroom: classroom,
                  token: token,
                )));
  }

  void handleEditClass(dynamic classroom) async {
    final SharedPreferences? prefs = await _prefs;
    var token = prefs?.get('token').toString();
    String title = '';
    String status = '';
    try {
      var response = await http.put(
          Uri.parse('http://localhost:3001/v1/classrooms/${classroom['id']}'),
          headers: {
            "Authorization": "Bearer ${token}",
          },
          body: {
            'title': title,
            'status': status,
          });
      if (response.statusCode == 200) {
        print("Xóa lớp học thành công!");
        getClassrooms();
      } else {
        print("Đã có lỗi xảy ra");
      }
    } catch (e) {
      print(e);
    }
  }
}
