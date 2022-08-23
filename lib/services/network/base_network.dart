import 'dart:convert';
import 'package:dio/dio.dart';
import '../../config/storage.dart';
import '../../models/response_model.dart';

enum RequestType { get, post }

Storage storage = Storage();

class BaseNetwork {
  // GetRequest
  getReq(
      String url, {
        Map<String, dynamic>? mapParam,
        FormData? formData,
        Function? onDataCallBack,
        Function? onErrorCallBack,
      }) {
    dioReq(RequestType.get,
        url: url,
        formData: formData,
        mapParam: mapParam,
        onDataCallBack: onDataCallBack,
        onErrorCallBack: onErrorCallBack);
  }

// PostRequest
  postReq(
      String url, {
        Map<String, dynamic>? mapParam,
        FormData? formData,
        Function? onDataCallBack,
        Function? onErrorCallBack,
      }) {
    dioReq(RequestType.post,
        url: url,
        formData: formData,
        mapParam: mapParam,
        onDataCallBack: onDataCallBack,
        onErrorCallBack: onErrorCallBack);
  }

// DioRequest
  dioReq(
      RequestType requestType, {
        required String url,
        Map<String, dynamic>? mapParam,
        FormData? formData,
        Function? onDataCallBack,
        Function? onErrorCallBack,
      }) async {
    BaseOptions options = BaseOptions();

    String? token = await storage.readSingleValue('token');

    if (token != 'null' || token != null) {
      options.headers = {"Authorization": token};
    }
    options.contentType = "application/json";
    options.validateStatus = (status) {
      return status! <= 500;
    };
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    ResponseModel responseModel = ResponseModel();

    try {
      Response response;

      // check request type
      if (requestType == RequestType.get) {
        if (mapParam != null) {
          response = await dio.get(url, queryParameters: mapParam);
        } else {
          response = await dio.get(url);
        }
      } else {
        if (mapParam != null || formData != null) {
          response = await dio.post(url, data: jsonEncode(mapParam));
        } else {
          response = await dio.post(url);
        }
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = response.data;
        responseModel.msgState = MsgState.data;
        responseModel.data = responseMap;
        onDataCallBack!(responseModel);
      } else if (response.statusCode == 404) {
        responseModel.data = 'Not Found Error';
        responseModel.msgState = MsgState.error;
        responseModel.errState = ErrState.notFoundErr;
        onErrorCallBack!(responseModel);
      } else if (response.statusCode == 500) {
        responseModel.data = 'Internal Server Error';
        responseModel.msgState = MsgState.error;
        responseModel.errState = ErrState.severErr;
        onErrorCallBack!(responseModel);
      } else {
        responseModel.data = 'Unknown Error';
        responseModel.msgState = MsgState.error;
        responseModel.errState = ErrState.unknownErr;
        onErrorCallBack!(responseModel);
      }
    } catch (e) {
      // print(e.toString());
      if (e.toString().contains('Connecting timed out') ||
          e.toString().contains('SocketException')) {
        responseModel.data = 'Unable To Connect!!';
        responseModel.msgState = MsgState.error;
        responseModel.errState = ErrState.noConnectionErr;
        onErrorCallBack!(responseModel);
      } else {
        responseModel.data = 'Unknown Error';
        responseModel.msgState = MsgState.error;
        responseModel.errState = ErrState.unknownErr;
        onErrorCallBack!(responseModel);
      }
    }
  }
}