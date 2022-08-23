class EarningResponseModel {
  EarningModel? result;

  EarningResponseModel({this.result});

  EarningResponseModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? EarningModel.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class EarningModel {
  int? totalEarnings;
  int? orderCount;
  List<RiderDetail>? riderDetail;

  EarningModel({this.totalEarnings, this.orderCount, this.riderDetail});

  EarningModel.fromJson(Map<String, dynamic> json) {
    totalEarnings = json['totalEarnings'];
    orderCount = json['orderCount'];
    if (json['riderDetail'] != null) {
      riderDetail = <RiderDetail>[];
      json['riderDetail'].forEach((v) {
        riderDetail!.add(RiderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalEarnings'] = totalEarnings;
    data['orderCount'] = orderCount;
    if (riderDetail != null) {
      data['riderDetail'] = riderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RiderDetail {
  String? orderId;
  int? deliveryFee;
  String? orderedDate;

  RiderDetail({this.orderId, this.deliveryFee, this.orderedDate});

  RiderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    deliveryFee = json['deliveryFee'];
    orderedDate = json['orderedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['deliveryFee'] = deliveryFee;
    data['orderedDate'] = orderedDate;
    return data;
  }
}