import 'package:apitestinglogin/ui/order_ui/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/orderListModel/new_order_model.dart';
import '../delivery_item_detail/delivery_item_detail.dart';

class Upcomming extends StatelessWidget {
  List<NewOrderResultModel> orderList;
  Function(String orderId, int changeStatus) updateStatus;
  Upcomming(this.orderList, {required this.updateStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          NewOrderResultModel model = orderList[index];
          if (model.riderOrderStatus == "1") {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return DeliveryItemDetail(
                      orderId: model.orderId!,
                    );
                  }),
                );
              },
              child: Card(
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
                              "Ready at ${DateTime.parse(model.orderDateTime!).hour}:${DateTime.parse(model.orderDateTime!).minute}",
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(model.orderDetail!),
                      Text(model.restaurantName!),
                      Text("${model.orderTotalAmount} item(s)"),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.map,
                              color: Color(0xFFF55F01),
                              size: 30,
                            ),
                          ),
                          Spacer(),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFF55F01),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Reject',
                                style: TextStyle(
                                  color: Color(0xFFF55F01),
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFF55F01),
                              ),
                              onPressed: () {
                                updateStatus(model.orderId!, 2);
                              },
                              child: Text('Accept')),
                        ],
                      ),
                    ],
                  ),
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
