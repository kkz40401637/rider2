class ProfileResponseModel {
  ProfileModels? result;

  ProfileResponseModel({this.result});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new ProfileModels.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ProfileModels {
  String? riderId;
  String? name;
  String? address;
  String? phone;
  String? email;
  bool? status;
  bool? isDisabled;
  String? joinedDate;
  String? riderStatus;

  ProfileModels(
      {this.riderId,
        this.name,
        this.address,
        this.phone,
        this.email,
        this.status,
        this.isDisabled,
        this.joinedDate,
        this.riderStatus});

  ProfileModels.fromJson(Map<String, dynamic> json) {
    riderId = json['riderId'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    isDisabled = json['isDisabled'];
    joinedDate = json['joinedDate'];
    riderStatus = json['riderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['riderId'] = this.riderId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['isDisabled'] = this.isDisabled;
    data['joinedDate'] = this.joinedDate;
    data['riderStatus'] = this.riderStatus;
    return data;
  }
}