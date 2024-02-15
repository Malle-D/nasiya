import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nasiya/data/model/sale_model.dart';

class GetUsersController extends GetxController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('sales');

  var logger = Logger();


  Stream<List<SaleModel>> getAllSalesData() {
    return users.snapshots().map((snapshot) => snapshot.docs
        .map((e) => SaleModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

}
