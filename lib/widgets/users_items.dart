import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/data/db_helper/db_helper.dart';
import 'package:github/data/model/db_user_model.dart';
import 'package:github/data/model/user_model.dart';

class UsersItems extends StatelessWidget {
  const UsersItems(
      {Key? key,
      required this.userModel,
      required this.onScrollNotification,
      required this.isReachEnd})
      : super(key: key);
  final List<UserModel> userModel;

  final bool isReachEnd;
  final bool Function(ScrollNotification) onScrollNotification;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: ListView.builder(
          itemCount: isReachEnd ? userModel.length : userModel.length + 1,
          itemBuilder: (context, i) {
            if (i >= userModel.length)
              return Center(
                  child: CupertinoActivityIndicator(
                radius: 15.0,
              ));

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage('${userModel[i].avatarUrl}'),
                ),
                title: Text('${userModel[i].login}'),
                subtitle: Text('${userModel[i].type}'),
                trailing: IconButton(
                    onPressed: () async {
                      final dbUserModel = DBUserModel(
                          name: '${userModel[i].login}',
                          type: '${userModel[i].type}',
                          avatar: '${userModel[i].avatarUrl}');
                      DBHelper().database;
                      await DBHelper().insertData(dbUserModel);
                    },
                    icon: Icon(Icons.save)),
              ),
            );
          }),
    );
  }
}
