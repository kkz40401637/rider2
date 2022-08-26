class DidResponseModel {
  DidModel? result;

  DidResponseModel({this.result});

  DidResponseModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new DidModel.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class DidModel {
  String? orderId;
  String? orderNo;
  int? tax;
  int? amount;
  int? deliveryFees;
  int? totalAmount;
  String? note;
  int? status;
  String? estimatedTime;
  String? orderDate;
  Customer? customer;
  Restaurant? restaurant;
  List<OrderItems>? orderItems;

  DidModel(
      {this.orderId,
      this.orderNo,
      this.tax,
      this.amount,
      this.deliveryFees,
      this.totalAmount,
      this.note,
      this.status,
      this.estimatedTime,
      this.orderDate,
      this.customer,
      this.restaurant,
      this.orderItems});

  DidModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    tax = json['tax'];
    amount = json['amount'];
    deliveryFees = json['deliveryFees'];
    totalAmount = json['totalAmount'];
    note = json['note'];
    status = json['status'];
    estimatedTime = json['estimatedTime'];
    orderDate = json['orderDate'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['tax'] = this.tax;
    data['amount'] = this.amount;
    data['deliveryFees'] = this.deliveryFees;
    data['totalAmount'] = this.totalAmount;
    data['note'] = this.note;
    data['status'] = this.status;
    data['estimatedTime'] = this.estimatedTime;
    data['orderDate'] = this.orderDate;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? customerId;
  String? phoneNo;
  String? name;
  String? address;

  Customer({this.customerId, this.phoneNo, this.name, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    phoneNo = json['phoneNo'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['phoneNo'] = this.phoneNo;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Restaurant {
  String? restaurantId;
  String? phoneNo;
  String? name;
  String? address;

  Restaurant({this.restaurantId, this.phoneNo, this.name, this.address});

  Restaurant.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    phoneNo = json['phoneNo'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['phoneNo'] = this.phoneNo;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class OrderItems {
  String? orderDetailId;
  String? menuName;
  int? qty;
  int? price;
  String? specialInstruction;

  OrderItems(
      {this.orderDetailId,
      this.menuName,
      this.qty,
      this.price,
      this.specialInstruction});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    menuName = json['menuName'];
    qty = json['qty'];
    price = json['price'];
    specialInstruction = json['specialInstruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderDetailId'] = this.orderDetailId;
    data['menuName'] = this.menuName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['specialInstruction'] = this.specialInstruction;
    return data;
  }
}
