import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logger/logger.dart';
import 'package:nasiya/data/local/preference/my_preference.dart';
import 'package:nasiya/data/model/sale_model.dart';

import '../model/user_model.dart';

class LoginController extends GetxController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var logger = Logger();
  Stream<List<UserModel>> getAllUsersData() {
    var list = FirebaseFirestore.instance
          .collection('users')
          .doc('admin');
    logger.d(list.id);
    return users.snapshots().map((snapshot) => snapshot.docs
        .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  // Future<void> getUser(UserModel userModel) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel.name)
  //       .set({'name': userModel.name, 'password': userModel.password});
  // }

  Future<void> updateUser(UserModel userModel) async {
    await users.doc(userModel.name).set(
        {'name': userModel.name, 'password': userModel.password}).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(MyPreference.getUserName())
          .delete();
    });
  }

// Future<void> closeSale(UserModel userModel) async {
//   await FirebaseFirestore.instance.collection('sales').doc(userModel.name).update({
//     'name': userModel.name,
//     'password' : userModel.password
//   });
// }

// Future<bool> checkUser(String saleModel) async {
//   var userDocRef = FirebaseFirestore.instance.collection('sales').doc(saleModel);
//   var doc = await userDocRef.get();
//   if (!doc.exists) {
//     return true;
//   } else {
//     return false;
//   }
// }
}
