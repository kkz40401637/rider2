import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@JsonSerializable()
class RequestNewToken {
  final String userId;
  final String refreshToken;

  RequestNewToken({required this.userId, required this.refreshToken});

  Map<String, dynamic> toJson() => _$RequestNewTokenToJson(this);
}
