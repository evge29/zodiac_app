// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zodiac_app/provaiders/signs_provaider.dart';
import 'package:zodiac_app/screens/detailscreen.dart';
import 'package:zodiac_app/screens/favoritescreen.dart';
import 'package:zodiac_app/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignsProv(),
        child: MaterialApp(
          title: 'Flutter App',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            DetailsScreen.routeName: (ctx) => const DetailsScreen(),
            FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          },
        ));
  }
}
