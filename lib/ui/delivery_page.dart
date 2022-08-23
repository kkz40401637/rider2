import 'package:apitestinglogin/config/storage.dart';
import 'package:apitestinglogin/services/api.dart';
import 'package:apitestinglogin/services/bloc/bloc/cubit/order_cubit.dart';
import 'package:apitestinglogin/services/bloc/bloc/order/order_bloc.dart';
import 'package:apitestinglogin/ui/order_ui/finished.dart';
import 'package:apitestinglogin/ui/order_ui/in_progress.dart';
import 'package:apitestinglogin/ui/widgets/list_view_behavior.dart';
import 'package:apitestinglogin/widgets/show_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_ui/upcomming.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  late Storage storage;
  late API api;
  int index = 0;
  int changeIndexNumber = 0;

  void loadOrderList() async {
    String? riderId = await storage.readSingleValue('customerId');
    BlocProvider.of<OrderCubit>(context).orderListRequest(
        riderId!,
        DateFormat('yyyy-MM-dd')
            .parse(DateTime.now().subtract(Duration(days: 3)).toString())
            .toString()
            .split(' ')
            .first,
        DateFormat('yyyy-MM-dd')
            .parse(DateTime.now().toString())
            .toString()
            .split(' ')
            .first);
  }

  @override
  void initState() {
    api = API();
    storage = Storage();
    loadOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: 3,
      child: Scaffold(
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OrderSuccess) {
              print("success...");
              if (changeIndexNumber != 0) {
                setState(() {
                  index = changeIndexNumber;
                });
              }
            }
          },
          builder: (context, state) {
            if (state is OrderSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      backgroundColor: const Color(0xFF5A5A5A),
                      bottom:  TabBar(
                        tabs: [
                          Tab(
                            text: tr('UPCOMING'),
                          ),
                          Tab(
                            text: tr('IN PROGRESS'),
                          ),
                          Tab(
                            text: tr('FINISHED'),
                          )
                        ],
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Upcomming(
                          state.orderList,
                          updateStatus: (orderId, changeStatus) {
                            showLoading(context);
                            api.UpdateOrderStatus(orderId, changeStatus)
                                .then((value) {
                              Navigator.of(context).pop();
                              setState(() {
                                changeIndexNumber = 1;
                              });
                              loadOrderList();
                            }).catchError((e) {
                              Navigator.of(context).pop();
                              print(e.toString());
                            });
                          },
                        ),
                        InProgress(state.orderList,
                            updateStatus: (orderId, changeStatus) {
                          showLoading(context);
                          api.UpdateOrderStatus(orderId, changeStatus)
                              .then((value) {
                            Navigator.of(context).pop();
                            setState(() {
                              changeIndexNumber = 2;
                            });
                            loadOrderList();
                          }).catchError((e) {
                            Navigator.of(context).pop();
                            print(e.toString());
                          });
                        }),
                        Finished(state.orderList),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            } else if (state is OrderFail) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
