import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/bloc/get_user_cubit/get_user_cubit.dart';
import 'package:github/widgets/my_profile_widget.dart';
import 'package:github/widgets/saved_users_items.dart';

import 'package:github/widgets/users_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getUser();
    super.initState();
  }

  bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is OverscrollNotification)
      BlocProvider.of<GetUserCubit>(context).getUsersLists(scrollInfo);

    return false;
  }

  _getUser() async {
    BlocProvider.of<GetUserCubit>(context).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub'),
      ),
      body: BlocListener<GetUserCubit, GetUserState>(
        listener: (context, state) {
          if (state is RequestProfile)
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Success'),
              backgroundColor: Colors.green,
            ));
        },
        child: SafeArea(
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserFailure)
                return Container(
                  child: Text('${state.error}'),
                );
              if (state is GetUserLoading)
                return Center(child: CircularProgressIndicator());
              if (state is GetUserSuccess)
                return UsersItems(
                  isReachEnd: state.isReachEnd,
                  onScrollNotification: (ScrollNotification notification) =>
                      _handleScrollNotification(notification),
                  userModel: state.userModel,
                );
              if (state is SavedUser)
                return SavedUserItems(
                  userModel: state.userModel,
                );
              if (state is RequestProfile)
                return MyProfileWidget(myProfile: state.myProfile);
              if (state is MyProfile)
                return MyProfileWidget(myProfile: state.myProfile);
              return Container();
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => _getUser(),
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () async {
                BlocProvider.of<GetUserCubit>(context).saveUser();
              },
              icon: Icon(Icons.save),
            ),
            IconButton(
              onPressed: () async {
                BlocProvider.of<GetUserCubit>(context).myProfile();
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
