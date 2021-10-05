import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/bloc/get_user_cubit/get_user_cubit.dart';

import '/view/home_screen.dart';
import 'data/core/api_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<GetUserCubit>(
          create: (context) => GetUserCubit(ApiClient()),
        ),
      ], child: HomeScreen()),
    );
  }
}
