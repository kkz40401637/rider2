import 'package:bloc/bloc.dart';

import '../../../models/profile/profile_model.dart';
import '../../api.dart';


part 'get_profile_state.dart';


class GetProfileCubit extends Cubit<GetProfileState> {
  API api = new API();

  GetProfileCubit() : super(GetProfileInitial()){
    getProfile();
  }

  void getProfile() {
    emit(GetProfileLoading());
    api.getProfileInfo().then((value) => emit(GetProfileSuccess(value))).catchError((e) => emit(GetProfileFail(e.toString())));
  }
}
