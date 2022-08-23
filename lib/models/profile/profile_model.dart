import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String? riderId;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final bool? status;
  final bool? isDisabled;
  final String? joinedDate;


  ProfileModel({
    required this.riderId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.status,
    required this.isDisabled,
    required this.joinedDate,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
