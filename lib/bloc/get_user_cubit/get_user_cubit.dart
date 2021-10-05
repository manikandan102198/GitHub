import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github/data/core/api_client.dart';
import 'package:github/data/db_helper/db_helper.dart';
import 'package:github/data/model/db_user_model.dart';
import 'package:github/data/model/my_profile_model.dart';
import 'package:github/data/model/request_user_model.dart';
import 'package:github/data/model/user_model.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit(this._apiClient) : super(GetUserInitial());

  final ApiClient _apiClient;
  List<UserModel> userModel = [];
  late MyProfileModel myProfileModel;

  void getUser() async {
    try {
      emit(GetUserLoading());
      userModel = await _apiClient.getUser();
      emit(GetUserSuccess(userModel: userModel));
    } catch (e) {
      print(e);
      emit(GetUserFailure(error: e.toString()));
    }
  }

  void saveUser() async {
    DBHelper().database;
    final dbUser = await DBHelper().getAllUsers();
    emit(SavedUser(userModel: dbUser));
  }

  void myProfile() async {
    try {
      emit(GetUserLoading());
      myProfileModel = await _apiClient.getMyProfile();
      emit(MyProfile(myProfile: myProfileModel));
    } catch (e) {
      print(e);
      emit(GetUserFailure(error: e.toString()));
    }
  }

  void requestUserModel() async {
    try {
      emit(GetUserLoading());
      final requestUser = await _apiClient.requestUser();
      emit(RequestProfile(
        myProfile: myProfileModel,
        requestUserModel: requestUser,
      ));
    } catch (e) {
      print(e);
      emit(GetUserFailure(error: e.toString()));
    }
  }
}
