import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:nasiya/data/controller/add_sale_controller.dart';
import 'package:nasiya/data/model/sale_model.dart';
import 'package:nasiya/presenter/components/text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<String> list = ['3 Month', '6 Month', '12 Month', '24 Month'];
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController realPriceController = TextEditingController();
  TextEditingController monthPriceController = TextEditingController();
  TextEditingController initialPaymentController = TextEditingController();
  TextEditingController commentController = TextEditingController();
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
          'Add Sale',
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
              textField(userNameController, "Customer Name *"),
              textFieldNumber(userPhoneController),
              textField(productController, "Product Name *"),
              Row(
                children: [
                  Flexible(
                    child: textFieldCount(realPriceController, "Real Price *"),
                  ),
                  Flexible(
                    child: textFieldCount(monthPriceController, "Month Price *"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: textFieldCount(initialPaymentController, "Initial Payment"),
                  ),
                  Flexible(
                    child: DropdownMenu(
                      initialSelection: list.first,
                      onSelected: (String? value) {
                          monthCount = value ?? list.first;
                          print("mounst on change $monthCount");
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              commentTextField(commentController),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  DateTime now = DateTime.now();
                  if (userNameController.text.isNotEmpty &&
                      productController.text.isNotEmpty &&
                      realPriceController.text.isNotEmpty &&
                      monthPriceController.text.isNotEmpty) {
                    if (await Get.find<RegisterController>()
                        .checkUser(userNameController.text)) {
                      Get.find<RegisterController>().addUser(SaleModel(
                          userNameController.text,
                          userPhoneController.text,
                          productController.text,
                          commentController.text,
                          int.parse(realPriceController.text),
                          monthCount.isEmpty ? list.first : monthCount,
                          int.parse(monthPriceController.text),
                          initialPaymentController.text.isNotEmpty ? int.parse(initialPaymentController.text) : 0,
                          int.parse(monthPriceController.text) * int.parse((monthCount.isEmpty ? list.first : monthCount).split(" ").first),
                          false,
                          false,
                          now.millisecondsSinceEpoch));
                      Get.back();
                    } else {
                      showToast('This User already Exist',
                          context: context,
                          animation: StyledToastAnimation.slideFromTopFade,
                          reverseAnimation: StyledToastAnimation.slideToTopFade,
                          position: StyledToastPosition(
                              align: Alignment.topCenter, offset: 0.0),
                          startOffset: Offset(0.0, -3.0),
                          reverseEndOffset: Offset(0.0, -3.0),
                          duration: Duration(seconds: 4),
                          //Animation duration   animDuration * 2 <= duration
                          animDuration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          reverseCurve: Curves.fastOutSlowIn);
                    }
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
                      'SUBMIT ORDER',
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
