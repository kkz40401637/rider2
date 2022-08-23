import 'package:apitestinglogin/services/network/base_network.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/response_model.dart';

class UpdateProfileBLoc extends BaseNetwork {
  final PublishSubject<ResponseModel> _controller =
  PublishSubject<ResponseModel>();
  Stream<ResponseModel> updProfileStream() => _controller.stream;

  doUpdate(Map<String, dynamic> map) async {
    ResponseModel responseModel = ResponseModel(msgState: MsgState.loading);
    _controller.sink.add(responseModel);

    String? riderId = await storage.readSingleValue('customerId');
    map['riderId'] = riderId;

    print(map);

    postReq(
      "https://forfoodieuat.bimats.com/api/rider/UpdateRiderProfile",
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