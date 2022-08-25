import 'package:flutter/material.dart';
import '../models/response_model.dart';

extension StreamExtensions on Stream<ResponseModel> {
  Widget streamWidget({
    required Widget Function(ResponseModel responseModel) successWidget,
    required Function tryAgain,
  }) {
    return StreamBuilder<ResponseModel>(
      initialData: ResponseModel(msgState: MsgState.loading),
      stream: this,
      builder: (constext, AsyncSnapshot<ResponseModel> snapshot) {
        ResponseModel? responseModel = snapshot.data;
        if (responseModel!.msgState == MsgState.data) {
          return successWidget(responseModel);
        } else if (responseModel.msgState == MsgState.error) {
          return Center(child: Text(responseModel.data));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget streamLoadingWidget({required Widget childWidget}) {
    return StreamBuilder<ResponseModel>(
      initialData: ResponseModel(),
      stream: this,
      builder: (context, AsyncSnapshot snapshot) {
        ResponseModel responseModel = snapshot.data;
        if (responseModel.msgState == MsgState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff00C851),
            ),
          );
        }
        return childWidget;
      },
    );
  }
}