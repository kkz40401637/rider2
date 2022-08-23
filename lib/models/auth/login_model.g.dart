// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      userName: json['userName'] as String,
      userType: json['userType'] as int,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userType': instance.userType,
      'password': instance.password,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expire: json['expire'] as String,
      user: Customer.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expire': instance.expire,
      'user': instance.user,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'userId': instance.userId,
    };
