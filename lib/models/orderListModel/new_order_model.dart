import 'package:json_annotation/json_annotation.dart';

part 'new_order_model.g.dart';

@JsonSerializable()
class NewOrderModel {
  final String riderId;
  final String startDate;
  final String endDate;

  NewOrderModel(
      {required this.riderId, required this.startDate, required this.endDate});

  factory NewOrderModel.fromJson(Map<String, dynamic> json) =>
      _$NewOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewOrderModelToJson(this);
}

@JsonSerializable()
class NewOrderResultModel {
  final String? orderId;
  final String? orderNo;
  final String? orderDetail;
  final int? orderTotalAmount;
  final int? deliveryFee;
  final String? orderDateTime;
  final String? restaurantName;
  final String? restaurantPhone;
  final String? riderId;
  final String? riderName;
  final String? riderOrderStatus;

  NewOrderResultModel(
      {this.orderId,
        this.orderNo,
      this.riderOrderStatus,
      this.orderDetail,
      this.orderTotalAmount,
      this.deliveryFee,
      this.orderDateTime,
      this.restaurantName,
      this.restaurantPhone,
      this.riderId,
      this.riderName});

  factory NewOrderResultModel.fromJson(Map<String, dynamic> json) =>
      _$NewOrderResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrderResultModelToJson(this);
}
