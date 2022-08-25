part of 'get_profile_cubit.dart';


abstract class GetProfileState {
  const GetProfileState();
  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}


class GetProfileSuccess extends GetProfileState {
  final ProfileModel profile;
  GetProfileSuccess(this.profile);
  @override
  List<Object> get props => [profile];
}

class GetProfileFail extends GetProfileState {
  final String error;
  GetProfileFail(this.error);

  @override
  List<Object> get props => [error];
}
