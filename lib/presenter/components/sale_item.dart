import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasiya/data/model/sale_model.dart';
import 'package:intl/intl.dart';
Widget saleItem(SaleModel saleModel, BuildContext context, void Function() details){
  String formattedDate = DateFormat('yyyy-MM-dd').format(
      DateTime.fromMillisecondsSinceEpoch(saleModel.saleTime));
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 170,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width- 20,
            height: 170,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: Color(0x338A959E),
                  blurRadius: 40,
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 15,
          child: Text(
            'Order ${saleModel.name}',
            style: const TextStyle(
              color: Color(0xFF232323),
              fontSize: 16,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 64,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Month: ',
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: saleModel.monthCount,
                  style: const TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 64,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Month Price: ',
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\$${saleModel.monthPrice}',
                  style: const TextStyle(
                    color: Color(0xFF232323),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 123,
          child: Text(
            'Total Price: \$${saleModel.monthPrice* int.parse(saleModel.monthCount.split(" ").first) + saleModel.initialPayment}',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF27AE60),
              fontSize: 16,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 93,
          child: Text(
            'Left: \$${saleModel.left}',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFF16768),
              fontSize: 16,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 116,
          child: InkWell(
            onTap: details,
            child: SizedBox(
              width: 100,
              height: 36,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 100,
                      height: 36,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF232323),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 29,
                    top: 7,
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 17,
          child: Text(
            formattedDate,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF808080),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    ),
  );
}