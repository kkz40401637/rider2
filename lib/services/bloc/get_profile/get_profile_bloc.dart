import 'package:apitestinglogin/models/profile/profile_response_model.dart';
import 'package:apitestinglogin/services/network/base_network.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/response_model.dart';

class ProfileBloc extends BaseNetwork {
  final PublishSubject<ResponseModel> _controller =
  PublishSubject<ResponseModel>();
  Stream<ResponseModel> getProfileStream() => _controller.stream;

  getProfileData() async {
    ResponseModel responseModel = ResponseModel(msgState: MsgState.loading);
    _controller.sink.add(responseModel);

    String? riderId = await storage.readSingleValue('customerId');

    postReq(
      "https://forfoodieuat.bimats.com/api/rider/GetRiderById",
      mapParam: {"riderId": riderId},
      onDataCallBack: (ResponseModel responseModel) {
        ProfileResponseModel profileResponseModel =
        ProfileResponseModel.fromJson(responseModel.data);
        responseModel.msgState = MsgState.data;
        responseModel.data = profileResponseModel.result;
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