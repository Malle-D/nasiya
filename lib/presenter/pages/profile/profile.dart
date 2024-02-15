import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasiya/data/local/preference/my_preference.dart';
import 'package:nasiya/presenter/screens/edit/edit_user_screen.dart';
import '../../components/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userName = MyPreference.getUserName();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 32),
                InkWell(
                  onTap: (){
                    Get.to(const EditUserScreen());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.person_outline_outlined, size: 30,),
                      const SizedBox(width: 16),
                      Text(userName, style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      )),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 20),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                profileItem(Icons.supervised_user_circle_outlined, "My Customers"),
                const SizedBox(height: 8),
                profileItem(Icons.shield_outlined, "Guarantors"),
                const SizedBox(height: 8),
                profileItem(Icons.chat_outlined, "Help"),
                const SizedBox(height: 8),
                InkWell(
                    onTap: (){
                      MyPreference.logOutUser();
                      Get.offAllNamed('/');
                    },
                    child: profileItem(Icons.logout, "Log Out")),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      )
      );
  }
}
