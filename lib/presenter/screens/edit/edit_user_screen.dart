import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:nasiya/data/controller/add_sale_controller.dart';
import 'package:nasiya/data/local/preference/my_preference.dart';
import 'package:nasiya/data/model/sale_model.dart';
import 'package:nasiya/data/model/user_model.dart';
import 'package:nasiya/presenter/components/text_field.dart';

import '../../../data/controller/login_controller.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  List<String> list = ['3 Month', '6 Month', '12 Month', '24 Month'];
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String monthCount = "";

  @override
  Widget build(BuildContext context) {
    // monthCount = list.first;
    // String dropdownValue = list.first;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Edit User',
          style: TextStyle(
            color: Color(0xFF232323),
            fontSize: 18,
            fontFamily: 'Gelasio',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textField(nameController, "New Login *"),
              const SizedBox(height: 16),
              textField(passController, "New Password *"),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  if (nameController.text.isNotEmpty &&
                      passController.text.isNotEmpty) {
                    Get.find<LoginController>().updateUser(
                        UserModel(nameController.text, passController.text));
                    MyPreference.setUser(nameController.text);
                    Get.offAllNamed('landing');
                  } else {
                    showToast('Fields is Empty',
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
                  decoration: ShapeDecoration(
                    color: const Color(0xFF232323),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F303030),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'SAVE CHANGES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
