class ResponseModel {
  MsgState? msgState;
  ErrState? errState;
  PageState? pageState;
  dynamic data;

  ResponseModel({this.msgState, this.errState, this.pageState, this.data});
}

enum MsgState {
  data,
  error,
  loading,
}

enum ErrState {
  unknownErr,
  notFoundErr,
  severErr,
  noConnectionErr,
  userErr,
}

enum PageState {
  first,
  load,
  noMore,
}