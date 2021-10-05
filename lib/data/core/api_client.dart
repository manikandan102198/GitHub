import 'package:github/data/model/my_profile_model.dart';
import 'package:github/data/model/request_user_model.dart';
import 'package:http/http.dart' as http;
import '/data/model/user_model.dart';

import 'api_constant.dart';

class ApiClient {
  Future<List<UserModel>> getUser() async {
    final response = await http
        .get(Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.GET_USER}'));
    if (response.statusCode == 200) {
      print("Response ${response.body}");
      final userModel = userModelFromJson(response.body);
      return userModel;
    } else {
      throw Exception(response);
    }
  }

  Future<MyProfileModel> getMyProfile() async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.BASE_URL}${ApiConstants.GET_USER}/${ApiConstants.MY_PROFILE}'));
    if (response.statusCode == 200) {
      print("Response ${response.body}");
      final profileModel = myProfileModelFromJson(response.body);
      return profileModel;
    } else {
      throw Exception(response);
    }
  }

  Future<RequestUserModel> requestUser() async {
    final response = await http.post(
        Uri.parse('${ApiConstants.REQ_URL}${ApiConstants.GET_USER}'),
        headers: {"Authorization": "token ${ApiConstants.token}"},
        body: {'name': 'name', 'developer': 'developer'});
    if (response.statusCode == 201) {
      print("Response ${response.body}");
      final req = requestUserModelFromJson(response.body);
      return req;
    } else {
      throw Exception(response);
    }
  }
}
