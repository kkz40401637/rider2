import 'package:apitestinglogin/ui/order_ui/finished.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../config/storage.dart';
import '../services/api.dart';
import '../services/bloc/bloc/cubit/order_cubit.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Storage storage;
  late API api;

  void loadOrderList() async {
    print("Loading Work");
    String? riderId = await storage.readSingleValue('customerId');
    BlocProvider.of<OrderCubit>(context).orderListRequest(
        riderId!,
        DateFormat('yyyy-MM-dd')
            .parse(DateTime.now().subtract(const Duration(days: 7)).toString())
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
    return Scaffold(
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) => print("Success..."),
        builder: (context, state) {
          if (state is OrderSuccess) {
            return Finished(
              state.orderList,
              isHistory: true,
            );
          } else if (state is OrderFail) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
