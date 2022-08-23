// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../../../models/orderListModel/new_order_model.dart';
// import '../../../api.dart';
//
// part 'order_event.dart';
// part 'order_state.dart';
//
//
// class OrderBloc extends Bloc<OrderEvent, OrderState> {
//   API api = API();
//   OrderBloc() : super(OrderInitialState()) {
//     on<NewOrderEvent>((event, emit) async {
//       emit(OrderLoading());
//       final activity = await _orderListRequest(event.riderId, event.startDate, event.endDate);
//       emit(OrderLoadedState(
//           orderList: activity,
//           neworder: 3,
//           accept: 0.1,
//           ready: 0.1,
//           complete: 0.1,
//           stsName: "New"));
//     });
//
//
//   }
//
//   Future<void> _orderListRequest(
//       String riderId,
//       String startDate,
//       String endDate,
//       ) async {
//     NewOrderModel orderModel = NewOrderModel(
//         riderId: riderId, startDate:startDate, endDate: endDate);
//     print(orderModel);
//    // NewOrderResultModel data = await api.orderList(orderModel);
//
//     // return (data);
//   }
//
// }
//
