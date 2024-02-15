import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasiya/presenter/components/sale_item.dart';
import 'package:nasiya/presenter/screens/add/add_screen.dart';
import 'package:nasiya/presenter/screens/detailst/details.dart';

import '../../../data/controller/get_sales_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  const Text.rich(
                    TextSpan(
                      children: [
                        // TextSpan(
                        //   text: 'Halol\n',
                        //   style: TextStyle(
                        //     color: Color(0xFF909090),
                        //     fontSize: 18,
                        //     fontFamily: 'Gelasio',
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        TextSpan(
                          text: 'NASIYA',
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
              print(snapshot.data);
              var list = snapshot.data ?? [];
              var currentList = list.where((element) => element.isClosed == false).toList();
              if (currentList.isNotEmpty) {
                return ListView.builder(
                    itemCount: currentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: saleItem(currentList[index], context,(){
                          Get.to(DetailsScreen(currentList[index]));
                        }),
                      );
                    });
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/placeholder.png"),
                      const Text("Sales List is Empty",
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
