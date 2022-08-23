import '../../../../models/orderListModel/new_order_model.dart';
import '../../../api.dart';
import 'package:bloc/bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {

  API api = API();


  OrderCubit() : super(OrderInitial());


  void orderListRequest(
      String riderId,
      String startDate,
      String endDate,
      )  {
    NewOrderModel orderModel = NewOrderModel(
        riderId: riderId, startDate:startDate, endDate: endDate);
    print(orderModel.toJson());
    api.orderList(orderModel).then((value) {
      emit(OrderSuccess(value));
    }).catchError((e){
      print("Error ${e.toString()}");
    });


  }


}