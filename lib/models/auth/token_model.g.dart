// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestNewToken _$RequestNewTokenFromJson(Map<String, dynamic> json) =>
    RequestNewToken(
      userId: json['userId'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$RequestNewTokenToJson(RequestNewToken instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'refreshToken': instance.refreshToken,
    };
