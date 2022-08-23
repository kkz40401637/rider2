// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderModel _$NewOrderModelFromJson(Map<String, dynamic> json) =>
    NewOrderModel(
      riderId: json['riderId'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$NewOrderModelToJson(NewOrderModel instance) =>
    <String, dynamic>{
      'riderId': instance.riderId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

NewOrderResultModel _$NewOrderResultModelFromJson(Map<String, dynamic> json) =>
    NewOrderResultModel(
      orderId: json['orderId'] as String?,
      orderNo: json['orderNo'] as String?,
      riderOrderStatus: json['riderOrderStatus'] as String?,
      orderDetail: json['orderDetail'] as String?,
      orderTotalAmount: json['orderTotalAmount'] as int?,
      deliveryFee: json['deliveryFee'] as int?,
      orderDateTime: json['orderDateTime'] as String?,
      restaurantName: json['restaurantName'] as String?,
      restaurantPhone: json['restaurantPhone'] as String?,
      riderId: json['riderId'] as String?,
      riderName: json['riderName'] as String?,
    );

Map<String, dynamic> _$NewOrderResultModelToJson(
        NewOrderResultModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderDetail': instance.orderDetail,
      'orderTotalAmount': instance.orderTotalAmount,
      'deliveryFee': instance.deliveryFee,
      'orderDateTime': instance.orderDateTime,
      'restaurantName': instance.restaurantName,
      'restaurantPhone': instance.restaurantPhone,
      'riderId': instance.riderId,
      'riderName': instance.riderName,
      'riderOrderStatus': instance.riderOrderStatus,
    };
