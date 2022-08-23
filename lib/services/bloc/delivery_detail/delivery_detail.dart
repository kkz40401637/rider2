import 'package:apitestinglogin/models/delivery_item_detail/delivery_item_detail.dart';
import 'package:apitestinglogin/services/network/base_network.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/response_model.dart';

class DeliveryDetailBloc extends BaseNetwork {
  final PublishSubject<ResponseModel> _controller =
      PublishSubject<ResponseModel>();
  Stream<ResponseModel> didStream() => _controller.stream;

  getDid({required String orderId, required String lang}) {
    ResponseModel responseModel = ResponseModel(msgState: MsgState.loading);
    _controller.sink.add(responseModel);

    getReq(
      "https://forfoodieuat.bimats.com/api/rider/getOrderDetailInfoByOrderId?OrderId=$orderId&LanguageType=$lang",
      onDataCallBack: (ResponseModel responseModel) {
        DidResponseModel didResponseModel =
            DidResponseModel.fromJson(responseModel.data);
        responseModel.msgState = MsgState.data;
        responseModel.data = didResponseModel.result;
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
