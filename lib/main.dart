import 'package:flutter/material.dart';
import 'package:prova_final/model/editProfile.dart';
import 'package:prova_final/model/home_page.dart';
import 'package:prova_final/movies/movies.dart';
import 'package:prova_final/model/search.dart';
import 'login/insertUser.dart';
import 'login/login.dart';
import 'model/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ButterPopCorn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromRGBO(255, 215, 0, 1)),
      initialRoute: '/login',
      routes: {
        '/': (context) => LoginScreen(),
        '/insert': (context) => AddedUser(),
        '/home': (context) => const HomeButterPopCorn(),
        '/search': (context) => const Search(),
        '/movies': (context) => const Movies(),
        '/profile': (context) => Profile(),
        '/editprofile': (context) => EditProfile(),
      },
    );
  }
}
