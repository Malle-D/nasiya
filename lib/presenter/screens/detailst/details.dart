import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:nasiya/data/model/sale_model.dart';
import 'package:nasiya/presenter/components/details.dart';
import 'package:telephony/telephony.dart';
import '../../../data/controller/add_sale_controller.dart';
import '../../components/text_field.dart';

class DetailsScreen extends StatefulWidget {
  final SaleModel saleModel;

  const DetailsScreen(this.saleModel, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController commentController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  bool isFavourite = false;
  String leftAfterPay = "";
  String _message = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      leftAfterPay = (widget.saleModel.left -
              (paidController.text.isNotEmpty
                  ? int.parse(paidController.text)
                  : 0))
          .toString();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Details',
              style: TextStyle(
                color: Color(0xFF232323),
                fontSize: 18,
                fontFamily: 'Gelasio',
                fontWeight: FontWeight.w700,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  onTap: () async {
                    await telephony.sendSms(to: "+998${widget.saleModel.phone}", message: "Dear ${widget.saleModel.name}\nIt's time for monthly payment\nBest regards from Nasiya!");
                    // await telephony.openDialer("+998939669960");
                  },
                  child: Text('Send Notification'),
                ),
                PopupMenuItem(
                  onTap: (){
                    Get.find<RegisterController>()
                        .closeSale(widget.saleModel);
                    Get.back();
                    Get.back();
                  },
                  child: const Text('Close Sale'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              detailsItem("Name:", widget.saleModel.name),
              const Divider(),
              detailsItem("Product:", widget.saleModel.products),
              const Divider(),
              detailsItem("Month Count:", widget.saleModel.monthCount),
              const Divider(),
              detailsItem("Month Price:", "${widget.saleModel.monthPrice}\$"),
              const Divider(),
              detailsItem("Real Price:", "${widget.saleModel.factPrice}\$"),
              const Divider(),
              detailsItem(
                  "Initial Payment:", "${widget.saleModel.initialPayment}\$"),
              const Divider(),
              detailsItem("Left Pay:", "${widget.saleModel.left}\$"),
              const Divider(),
              detailsItem(
                  "Seal Time:",
                  DateTime.fromMillisecondsSinceEpoch(widget.saleModel.saleTime)
                      .toString()),
              const Divider(),
              Row(
                children: [
                  Flexible(child: textFieldCount(paidController, "Paid")),
                  Flexible(
                      child: detailsItem("Left af. Pay:", leftAfterPay))
                  // Flexible(child: Text(leftAfterPay))
                ],
              ),
              const SizedBox(height: 16),
              detailsItem("Comments:", widget.saleModel.comment),
              const SizedBox(height: 16),
              const Text("Add new comment:",
                  style: TextStyle(color: Colors.black45, fontSize: 12)),
              const SizedBox(height: 4),
              commentTextField(commentController),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.saleModel.isFavourite =
                            !widget.saleModel.isFavourite;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(18),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF0F0F0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Center(
                        child: Icon(widget.saleModel.isFavourite
                            ? Icons.bookmark
                            : Icons.bookmark_border),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if(paidController.text.isNotEmpty && int.parse(paidController.text) > widget.saleModel.left){
                        showToast('Incorrect paid sum',
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
                      } else {
                        if (commentController.text.isNotEmpty) {
                          Get.find<RegisterController>().updateUser(SaleModel(
                              widget.saleModel.name,
                              widget.saleModel.phone,
                              widget.saleModel.products,
                              "${widget.saleModel.comment.trim()}\n${commentController.text.trim()}",
                              widget.saleModel.factPrice,
                              widget.saleModel.monthCount,
                              widget.saleModel.monthPrice,
                              widget.saleModel.initialPayment,
                              widget.saleModel.left - (paidController.text.isNotEmpty
                                  ? int.parse(paidController.text)
                                  : 0),
                              widget.saleModel.isFavourite,
                              widget.saleModel.isClosed,
                              widget.saleModel.saleTime));
                        } else {
                          Get.find<RegisterController>().updateUser(SaleModel(
                              widget.saleModel.name,
                              widget.saleModel.phone,
                              widget.saleModel.products,
                              widget.saleModel.comment,
                              widget.saleModel.factPrice,
                              widget.saleModel.monthCount,
                              widget.saleModel.monthPrice,
                              widget.saleModel.initialPayment,
                              widget.saleModel.left - (paidController.text.isNotEmpty
                                  ? int.parse(paidController.text)
                                  : 0),
                              widget.saleModel.isFavourite,
                              widget.saleModel.isClosed,
                              widget.saleModel.saleTime));
                        }
                        Get.back();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 110,
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
                          'SAVE',
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
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}


onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}