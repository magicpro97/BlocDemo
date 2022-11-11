import 'package:bloc_demo/people_repository.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'home_page_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        homePageBloc: HomePageBloc(PeopleRepositoryImpl()),
      ),
    );
  }
}
