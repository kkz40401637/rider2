import 'package:apitestinglogin/models/earning/earning_model.dart';
import 'package:apitestinglogin/services/network/base_network.dart';
import 'package:rxdart/rxdart.dart';
import '../../../config/storage.dart';
import '../../../models/response_model.dart';

Storage storage = Storage();

class GetEarnBLoc extends BaseNetwork {
  final PublishSubject<ResponseModel> _controller =
  PublishSubject<ResponseModel>();
  Stream<ResponseModel> earnStream() => _controller.stream;

  getEarning({required String startDate, required String endDate}) async {
    ResponseModel responseModel = ResponseModel(msgState: MsgState.loading);
    _controller.sink.add(responseModel);

    String? riderId = await storage.readSingleValue('customerId');

    postReq(
      "https://forfoodieuat.bimats.com/api/rider/GetRiderReport",
      mapParam: {
        "keyword": "",
        "rowLimit": 0,
        "currentPage": 0,
        "sortBy": "",
        "isDesc": true,
        "language": 0,
        "riderId": riderId,
        "startDate": startDate,
        "endDate": endDate
      },
      onDataCallBack: (ResponseModel responseModel) {
        EarningResponseModel earningResponseModel =
        EarningResponseModel.fromJson(responseModel.data);
        responseModel.msgState = MsgState.data;
        responseModel.data = earningResponseModel.result;
        _controller.sink.add(responseModel);
      },
      onErrorCallBack: (ResponseModel responseModel) {
        _controller.sink.add(responseModel);
      },
    );
  }

  dispose() {
    _controller.close();
  }
}