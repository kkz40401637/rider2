import 'package:flutter/material.dart';
import 'package:apitestinglogin/models/orderListModel/new_order_model.dart';

class InProgress extends StatefulWidget {
  List<NewOrderResultModel> orderList;
  Function(String orderId, int changeStatus) updateStatus;
  InProgress(this.orderList, {required this.updateStatus});

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  Map<String, bool> orderPickUp = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: widget.orderList.length,
        itemBuilder: (context, index) {
          NewOrderResultModel model = widget.orderList[index];
          if (model.riderOrderStatus == "2") {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(model.orderNo!),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            orderPickUp.containsKey(model.orderId)
                                ? "Pick Up"
                                : "Ready at ${DateTime.parse(model.orderDateTime!).hour}:${DateTime.parse(model.orderDateTime!).minute}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rider Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(model.orderDetail!),
                    Text(model.restaurantName!),
                    Text("${model.orderTotalAmount} item(s)"),
                    Row(
                      children: [
                        Icon(
                          Icons.map,
                          color: Color(0xFFF55F01),
                          size: 30,
                        ),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF55F01),
                            ),
                            onPressed: () {
                              if (orderPickUp.containsKey(model.orderId)) {
                                widget.updateStatus(model.orderId!, 3);
                              } else {
                                setState(() {
                                  orderPickUp[model.orderId!] = true;
                                });
                              }
                            },
                            child: Text(orderPickUp.containsKey(model.orderId)
                                ? "Complete"
                                : 'Pick Up')),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
