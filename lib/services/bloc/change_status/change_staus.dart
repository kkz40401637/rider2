import 'package:apitestinglogin/services/network/base_network.dart';
import 'package:rxdart/rxdart.dart';
import '../../../models/response_model.dart';

class ChangeStatusBloc extends BaseNetwork {
  final PublishSubject<ResponseModel> _controller =
  PublishSubject<ResponseModel>();
  Stream<ResponseModel> changeStatusStream() => _controller.stream;

  changeStatus({required String isOnline}) async {
    ResponseModel responseModel = ResponseModel(msgState: MsgState.loading);
    _controller.sink.add(responseModel);

    bool? isAvailable;

    if (isOnline == "Online") {
      isAvailable = true;
    } else {
      isAvailable = false;
    }

    // print(
    //     "isOnline :: $isOnline -----  isAviable :: ${isAvailable.toString()}");

    String? riderId = await storage.readSingleValue('customerId');

    Map<String, dynamic> map = {"riderId": riderId, "isAvailable": isAvailable};

    postReq(
      "https://forfoodieuat.bimats.com/api/rider/UpdateRiderStatus",
      mapParam: map,
      onDataCallBack: (ResponseModel responseModel) {
        responseModel.msgState = MsgState.data;
        responseModel.data = '';
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