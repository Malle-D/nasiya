import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nasiya/data/controller/login_controller.dart';
import 'package:nasiya/data/local/preference/my_preference.dart';

import '../../../data/model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Get.find<LoginController>().getAllUsersData(),
        builder: (context, snapshot) {
          var list = snapshot.data ?? [];
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            color: Color(0xFFBDBDBD),
                            height: 1,
                          )),
                          Expanded(
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          const Expanded(
                              child: Divider(
                            color: Color(0xFFBDBDBD),
                            height: 1,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hello !\n',
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 30,
                                fontFamily: 'Merriweather',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'WELCOME BACK',
                              style: TextStyle(
                                color: Color(0xFF303030),
                                fontSize: 24,
                                fontFamily: 'Merriweather',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x338A959E),
                              blurRadius: 30,
                              offset: Offset(0, 7),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 16, bottom: 16),
                          child: Column(
                            children: [
                              TextField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(10),
                                  label: Text('User Name'),
                                  labelStyle: TextStyle(
                                      color: Color(0xFF909090),
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE0E0E0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE0E0E0)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextField(
                                controller: passController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(10),
                                  label: Text('Password'),
                                  labelStyle: TextStyle(
                                      color: Color(0xFF909090),
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE0E0E0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE0E0E0)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, left: 14),
                                child: InkWell(
                                  onTap: () {
                                    var logger = Logger();
                                    logger.d(list.length);
                                    // logger.d(list.first.name);
                                    if (checkUser(list, nameController.text,
                                        passController.text)) {
                                      MyPreference.setUser(nameController.text);
                                      MyPreference.registerUser();
                                      Get.offAllNamed('landing');
                                    } else {
                                      showToast('Login or Password is Wrong',
                                          context: context,
                                          animation: StyledToastAnimation.slideFromTopFade,
                                          reverseAnimation: StyledToastAnimation.slideToTopFade,
                                          position: const StyledToastPosition(
                                              align: Alignment.topCenter, offset: 0.0),
                                          startOffset: Offset(0.0, -3.0),
                                          reverseEndOffset: Offset(0.0, -3.0),
                                          duration: Duration(seconds: 4),
                                          //Animation duration   animDuration * 2 <= duration
                                          animDuration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          reverseCurve: Curves.fastOutSlowIn);
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF232323),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

bool checkUser(List<UserModel> list, String name, String pass) {

  for (var o in list) {
    print(o.name);
    print(o.password);
    if(o.name == name && o.password == pass){
      return true;
    }
  }
  return false;
}
