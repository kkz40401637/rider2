import 'package:apitestinglogin/ui/delivery_item_detail/delivery_item_detail.dart';
import 'package:flutter/material.dart';

import '../../models/orderListModel/new_order_model.dart';

class Finished extends StatelessWidget {
  final List<NewOrderResultModel> orderList;
  Finished(this.orderList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          NewOrderResultModel model = orderList[index];
          if (model.riderOrderStatus == "3") {
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
                            "Complete",
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
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF55F01),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return DeliveryItemDetail(
                                    orderId: model.orderId!,
                                  );
                                }),
                              );
                            },
                            child: Text('View Detail')),
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
