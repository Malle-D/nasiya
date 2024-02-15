import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nasiya/data/model/sale_model.dart';

class RegisterController extends GetxController {
  Future<void> addUser(SaleModel saleModel) async {
      await FirebaseFirestore.instance.collection('sales').doc(saleModel.name).set({
        'name': saleModel.name,
        'phone' : saleModel.phone,
        'products': saleModel.products,
        'comment': saleModel.comment,
        'price': saleModel.factPrice,
        'monthPrice': saleModel.monthPrice,
        'monthCount': saleModel.monthCount,
        'initialPayment':saleModel.initialPayment,
        'left':saleModel.left,
        'isFavourite': saleModel.isFavourite,
        'isClosed': saleModel.isClosed,
        'saleTime': saleModel.saleTime,
      });
  }

  Future<void> updateUser(SaleModel saleModel) async {
    await FirebaseFirestore.instance.collection('sales').doc(saleModel.name).update({
      'name': saleModel.name,
      'phone' : saleModel.phone,
      'products': saleModel.products,
      'comment': saleModel.comment,
      'price': saleModel.factPrice,
      'monthPrice': saleModel.monthPrice,
      'monthCount': saleModel.monthCount,
      'initialPayment' : saleModel.initialPayment,
      'isFavourite': saleModel.isFavourite,
      'left':saleModel.left,
      'isClosed': saleModel.isClosed,
      'saleTime': saleModel.saleTime,
    });
  }

  Future<void> closeSale(SaleModel saleModel) async {
    await FirebaseFirestore.instance.collection('sales').doc(saleModel.name).update({
      'name': saleModel.name,
      'phone' : saleModel.phone,
      'products': saleModel.products,
      'comment': saleModel.comment,
      'price': saleModel.factPrice,
      'monthPrice': saleModel.monthPrice,
      'monthCount': saleModel.monthCount,
      'initialPayment' : saleModel.initialPayment,
      'left':saleModel.left,
      'isFavourite': saleModel.isFavourite,
      'isClosed': true,
      'saleTime': saleModel.saleTime,
    });
  }

  Future<bool> checkUser(String saleModel) async {
    var userDocRef = FirebaseFirestore.instance.collection('sales').doc(saleModel);
    var doc = await userDocRef.get();
    if (!doc.exists) {
      return true;
    } else {
      return false;
    }
  }


}
