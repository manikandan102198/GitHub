import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/bloc/get_user_cubit/get_user_cubit.dart';
import 'package:github/data/model/my_profile_model.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({Key? key, required this.myProfile}) : super(key: key);
  final MyProfileModel myProfile;
  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            BlocProvider.of<GetUserCubit>(context).requestUserModel();
          },
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('${widget.myProfile.avatarUrl}'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name :'),
            Text('${widget.myProfile.login}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Type:'),
            Text('${widget.myProfile.type}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Public Repos:'),
            Text('${widget.myProfile.publicRepos}'),
          ],
        ),
      ],
    );
  }
}
