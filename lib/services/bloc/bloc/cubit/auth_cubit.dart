import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/storage.dart';
import '../../../../models/auth/login_model.dart';
import '../../../api.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  API api = API();
  Storage storage = Storage();

  AuthCubit() : super(AuthInitial());


  void login(LoginModel loginModel) {
    emit(LoginLoading());
    api.login(loginModel).then((value) async {
      await storage.saveValue('token', "Bearer ${value.token}");
      await storage.saveValue('customerId', value.user.userId);
      await storage.saveValue('refresh-token', value.refreshToken);
      print("This is refersh token" + value.refreshToken);
      emit(LoginSuccess(value));
    }).catchError((e) => emit(LoginFail(e.toString())));
  }


}

