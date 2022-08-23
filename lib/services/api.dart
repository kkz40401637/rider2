import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/storage.dart';
import '../models/auth/login_model.dart';
import '../models/auth/token_model.dart';
import '../models/profile/profile_model.dart';
import 'package:apitestinglogin/config/storage.dart';
import 'package:apitestinglogin/models/orderListModel/new_order_model.dart';

// import '../models/orderL_list_model.dart';

//const String baseUrl = "https://forfoodieuat.bimats.com/api/rider/";

Storage storage = Storage();

class API {
  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
        Uri.parse('https://forfoodieuat.bimats.com/api/auth/authenticate'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(loginModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      print("This is Login" + response.body);
      return LoginResponseModel.fromJson(parsed);
    } else {
      throw response.body;
    }
  }

  Future<String> logout() async {
    String? token = await storage.readSingleValue('token');
    String? userId = await storage.readSingleValue('customerId');

    final response = await http.post(
      Uri.parse('https://forfoodieuat.bimats.com/api/auth/Logout'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token!,
      },
      body: json.encode({
        "userId": userId!,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }

  Future<ProfileModel> getProfileInfo() async {
    String? token = await storage.readSingleValue('token');
    String? riderId = await storage.readSingleValue('customerId');

    print("Printing " + riderId!);
    try {
      final response = await http.post(
          Uri.parse('https://forfoodieuat.bimats.com/api/rider/GetRiderById'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: token!
          },
          body: jsonEncode({
            'riderId': riderId,
          }));
      print('get profile');
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body)['result'];

        return ProfileModel.fromJson(parsed);
      } else {
        throw response.body;
      }
    } catch (e) {
      print(e.toString());
      throw 'errorr';
    }
  }

  Future<String> UpdateRiderStatus(String orderId, bool isAvailable) async {
    String? token = await storage.readSingleValue('token');
    String? riderId = await storage.readSingleValue('customerId');

    final response = await http.post(
        Uri.parse(
            'https://forfoodieuat.bimats.com/api/rider/UpdateRiderStatus'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
        body: jsonEncode({
          "riderId": riderId,
          "isAvailable": isAvailable,
        }));
    print(response.body);

    if (response.statusCode == 200) {
      print("Update Rider Success");
      return response.body;
    } else {
      print("Error Rider Status");
      return response.body;
    }
  }

  Future<String> UpdateOrderStatus(String orderId, int status) async {
    print(orderId);
    String? token = await storage.readSingleValue('token');
    String? riderId = await storage.readSingleValue('customerId');
    try {
      final response = await http.post(
          Uri.parse(
              'https://forfoodieuat.bimats.com/api/rider/UpdateRiderOrderStatusByOrderId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: token!
          },
          body: jsonEncode({
            "riderId": riderId,
            "orderId": orderId,
            "status": status,
          }));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("Update Order Status");
        return response.body;
      } else {
        print("Error Order Status");
        return response.body;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<NewOrderResultModel>> orderList(NewOrderModel orderList) async {
    String? token = await storage.readSingleValue('token');
    print("This is order list " +
        orderList.riderId +
        orderList.startDate.toString() +
        orderList.endDate.toString());

    final response = await http.post(
        Uri.parse(
            'https://forfoodieuat.bimats.com/api/rider/GetOrderListByRiderIdWithDateRange'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
        body: json.encode(orderList.toJson()));

    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonParsed = json.decode(response.body)['result'];
      print("Order list is" + response.body);
      return jsonParsed
          .map<NewOrderResultModel>((e) => NewOrderResultModel.fromJson(e))
          .toList();
    } else {
      throw response.body;
    }
  }
}
