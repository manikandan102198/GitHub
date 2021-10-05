part of 'get_user_cubit.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final List<UserModel> userModel;
  final bool isReachEnd;

  GetUserSuccess( {required this.isReachEnd,required this.userModel});

  @override
  List<Object> get props => [userModel,isReachEnd];
}

class SavedUser extends GetUserState {
  final List<DBUserModel> userModel;

  SavedUser({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class MyProfile extends GetUserState {
  final MyProfileModel myProfile;

  MyProfile({required this.myProfile});

  @override
  List<Object> get props => [myProfile];
}

class RequestProfile extends GetUserState {
  final RequestUserModel requestUserModel;
  final MyProfileModel myProfile;
  RequestProfile({required this.requestUserModel, required this.myProfile});

  @override
  List<Object> get props => [requestUserModel, myProfile];
}

class GetUserFailure extends GetUserState {
  final String error;

  GetUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
