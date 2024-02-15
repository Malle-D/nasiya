import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:nasiya/data/model/sale_model.dart';
import 'package:nasiya/presenter/components/sale_item.dart';
import 'package:nasiya/presenter/screens/add/add_screen.dart';
import 'package:nasiya/presenter/screens/detailst/details.dart';
import '../../../data/controller/get_sales_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Get.find<GetUsersController>().getAllSalesData(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(0xd000000),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        // sendingSMS('Hello, this the test message', ['+998939669960']);
                      },
                      icon: const Icon(Icons.search)),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Pay\n',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 18,
                            fontFamily: 'Gelasio',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'In This Week',
                          style: TextStyle(
                            color: Color(0xFF232323),
                            fontSize: 18,
                            fontFamily: 'Gelasio',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(const AddScreen());
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
            body: Builder(builder: (BuildContext context) {
              var list = snapshot.data ?? [];
              var notificationList = list
                  .where((element) =>
                      element.isClosed == false && checkTime(element) == true)
                  .toList();
              if (notificationList.isNotEmpty) {
                return ListView.builder(
                    itemCount: notificationList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: saleItem(notificationList[index], context, () {
                          Get.to(DetailsScreen(notificationList[index]));
                        }),
                      );
                    });
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/placeholder.png"),
                      const Text("Notification List is Empty",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              fontSize: 18))
                    ],
                  ),
                );
              }
            }),
          );
        });
  }
}

bool checkTime(SaleModel saleModel) {
  int monthCount = int.parse(saleModel.monthCount.split(" ").first);
  for (int i = 1; i <= monthCount; i++) {
    if (Jiffy.parse("${DateTime.now()}").isBefore(Jiffy.parse(
                "${DateTime.fromMillisecondsSinceEpoch(saleModel.saleTime)}")
            .add(months: i)) &&
        Jiffy.parse("${DateTime.now()}").isAfter(Jiffy.parse(
                "${DateTime.fromMillisecondsSinceEpoch(saleModel.saleTime)}")
            .add(months: i)
            .subtract(weeks: 1))) {
      return true;
    }
  }
  return false;
}

// void printTime() {
//   var logger = Logger();
//
//   logger.d(Jiffy.parse("${DateTime.fromMillisecondsSinceEpoch(1706401075761)}").add(months: 1).format());
//   // if (.isBefore(Jiffy.parse(
//   //     "${DateTime.fromMillisecondsSinceEpoch(saleModel.saleTime)}")
//   //     .add(months: i)) &&
//   //     Jiffy.parse("${DateTime.now()}").isAfter(Jiffy.parse(
//   //         "${DateTime.fromMillisecondsSinceEpoch(saleModel.saleTime)}")
//   //         .add(months: i)
//   //         .subtract(weeks: 1))) {
//   //   return true;
//   // }
// }
