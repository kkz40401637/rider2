part of 'order_cubit.dart';

abstract class OrderState {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState{
  List<NewOrderResultModel> orderList = [];
  OrderSuccess(this.orderList);

  @override
  List<Object> get props => [orderList];
}

class OrderFail extends OrderState{
  final String error;
  OrderFail(this.error);

  @override
  List<Object> get props => [error];
}