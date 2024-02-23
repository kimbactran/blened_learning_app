import 'dart:convert';

import 'package:blended_learning_appmb/features/authentication/controllers/login_controller.dart';
import 'package:blended_learning_appmb/features/admin/adminPage.dart';
import 'package:blended_learning_appmb/features/student/studentPage.dart';
import 'package:blended_learning_appmb/screens/teacher/teacherPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  bool _showPassword = true;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  var _emailMessageErr = "";
  var _passwordMessageErr = "";
  bool _emailInvalid = false;
  bool _passwordInvalid = false;
  String _role = "";
  void loginSuccess(String email, password) async {
    try {
      var response = await http.post(
          Uri.parse('http://localhost:3001/v1/auth/login')
          //, headers: {
          //   "Access-Control-Allow-Origin": "*",
          //   'Content-Type': 'application/json',
          //   'Accept': '*/*'
          // }
          ,
          body: {
            'email': email,
            'password': password,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data['user']['role'] == 'ADMIN') {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminPage()));
        } else if (data['user']['role'] == 'TEACHER') {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TeacherPage()));
        } else if (data['user']['role'] == 'STUDENT') {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StudentPage()));
        } else
          print("The login user's role cannot be determined!");
        print(_role);
        // print(data['user']['role']);
        print('Login successfully');
      } else {
        print('failed');
        setState(() {
          _emailInvalid = true;
          _passwordInvalid = true;
          _emailMessageErr = "Email is't not correct";
          _passwordMessageErr = "Mật is't not correct";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logos/logo.png'),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                controller: loginController.emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _emailInvalid ? _emailMessageErr : null,
                    labelStyle: const TextStyle(
                        color: Color(0xff888888), fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextField(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        controller: loginController.passwordController,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            errorText:
                                _passwordInvalid ? _passwordMessageErr : null,
                            labelStyle: const TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                    ),
                    GestureDetector(
                      onTap: onIconShowPassword,
                      child: Icon(
                          _showPassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: const Color(0xff888888),
                          weight: 14),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Color(0xFF3D0099)),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  onPressed: () => loginController.login(),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  void onIconShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void onSignInClicked() async {
    setState(() {
      if (_emailController.text.length == 0) {
        _emailInvalid = true;
        _emailMessageErr = "Email is invalid";
      } else if (!_emailController.text.contains("@")) {
        _emailInvalid = true;
        _emailMessageErr = "Email must be contain @";
      }
      if (_passwordController.text.length == 0) {
        _passwordInvalid = true;
        _passwordMessageErr = "Password is invalid";
      }
    });
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();
    loginSuccess(email, password);
    if (!_emailInvalid && !_passwordInvalid) {
      loginSuccess(email, password);
    }
  }
}
