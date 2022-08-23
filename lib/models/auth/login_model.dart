import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String userName;
  final int userType;
  final String password;

  LoginModel({required this.userName,required this.userType,required this.password});
  factory LoginModel.fromJson(Map<String,dynamic>json)=> _$LoginModelFromJson(json);

  Map<String,dynamic> toJson()=> _$LoginModelToJson(this);

}


@JsonSerializable()
class LoginResponseModel {
  final String token;
  final String refreshToken;
  final String expire;
  final Customer user;

  LoginResponseModel({
    required this.token,
    required this.refreshToken,
    required this.expire,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

@JsonSerializable()
class Customer {
  final String userId;

  Customer({required this.userId});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}


