import 'package:apitestinglogin/models/delivery_item_detail/delivery_item_detail.dart';
import 'package:apitestinglogin/models/response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:apitestinglogin/utils/stream_ext.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/bloc/delivery_detail/delivery_detail.dart';

class DeliveryItemDetail extends StatelessWidget {
  final String orderId;
  const DeliveryItemDetail({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = DeliveryDetailBloc();
    bloc.getDid(orderId: orderId, lang: "1");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 219, 212, 212)),
        backgroundColor: const Color(0xFFF55F01),
        title: Text(
          tr("Delivery Detail"),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.headset_mic),
            onPressed: () {},
          )
        ],
      ),
      body: bloc.didStream().streamWidget(
        successWidget: (ResponseModel responseModel) {
          DidModel didModel = responseModel.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: const Color(0xffF2F2F7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          didModel.orderNo!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0x80000000),
                          ),
                        ),
                        Text(
                          "Ready at ${didModel.estimatedTime}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0x80000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Customer
                  Text(
                    tr("CUSTOMER"),
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFFF55F01),
                      fontWeight: FontWeight.w500,
                      letterSpacing:
                          context.locale == const Locale("my", "MM") ? null : 5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    didModel.customer!.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    didModel.customer!.address!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        didModel.customer!.phoneNo!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0x80000000),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFF55F01), shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launchUrl(Uri(
                                scheme: 'tel',
                                path: didModel.customer!.phoneNo!));
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 10,
                    color: const Color(0xffF2F2F7),
                  ),
                  //  RESTAURANT
                  Text(
                    tr("RESTAURANT"),
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFFF55F01),
                      fontWeight: FontWeight.w500,
                      letterSpacing:
                          context.locale == const Locale("my", "MM") ? null : 5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    didModel.restaurant!.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    didModel.restaurant!.address!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        didModel.restaurant!.phoneNo!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0x80000000),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFF55F01), shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launchUrl(Uri(
                                scheme: 'tel',
                                path: didModel.restaurant!.phoneNo!));
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 10,
                    color: const Color(0xffF2F2F7),
                  ),
                  // ORDER SUMMARY
                  Text(
                    tr("ORDER SUMMARY"),
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFFF55F01),
                      fontWeight: FontWeight.w500,
                      letterSpacing:
                          context.locale == const Locale("my", "MM") ? null : 5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${didModel.orderItems![0].qty!}x",
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.orderItems![0].menuName!,
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.orderItems![0].price!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.amount!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tax",
                        style: TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.tax!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Delivery Fee",
                        style: TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.deliveryFees!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        didModel.totalAmount!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        tryAgain: () {
          bloc.getDid(orderId: orderId, lang: "1");
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFF55F01)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Accept"),
        ),
      ),
    );
  }
}
