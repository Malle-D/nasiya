import 'package:shared_preferences/shared_preferences.dart';

class MyPreference {
  static late final SharedPreferences _pref;

  static void init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void setUser(String username) {
    _pref.setString("user", username);
  }

  static String getUserName() {
    return _pref.getString("user") ?? "";
  }

  static void registerUser(){
    _pref.setBool("register", true);
  }

  static void logOutUser(){
    _pref.setBool("register", false);
  }

  static bool isRegistered(){
    return _pref.getBool("register") ?? false;
  }
}