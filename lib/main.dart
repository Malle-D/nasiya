import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasiya/data/controller/get_sales_controller.dart';
import 'package:nasiya/presenter/screens/landing/landing_screen.dart';
import 'package:nasiya/presenter/screens/login/login_screen.dart';

import 'data/controller/add_sale_controller.dart';
import 'data/controller/login_controller.dart';
import 'data/local/preference/my_preference.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyPreference.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(GetUsersController());
    if(MyPreference.isRegistered()){
      return GetMaterialApp(
        defaultTransition: Transition.fade,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'landing',
        routes: {
          '/': (context) => const LoginScreen(),
          'landing': (context) => const LandingScreen(currentPage: 0),
        },
      );
    } else {
      return GetMaterialApp(
        defaultTransition: Transition.fade,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          'landing': (context) => const LandingScreen(currentPage: 0),
        },
      );
    }
  }
}
