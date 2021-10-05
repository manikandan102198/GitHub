import 'package:flutter/material.dart';
import 'package:github/data/model/db_user_model.dart';

class SavedUserItems extends StatelessWidget {
  const SavedUserItems({Key? key, required this.userModel}) : super(key: key);
  final List<DBUserModel> userModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: userModel.length,
        itemBuilder: (context, i) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 5.0,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${userModel[i].avatar}'),
              ),
              title: Text('${userModel[i].name}'),
              subtitle: Text('${userModel[i].type}'),
            ),
          );
        });
  }
}
