import 'package:flutter/material.dart';
import 'package:zodiac_app/screens/favoritescreen.dart';

import '../widgets/signs_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final String route = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 184, 56, 99),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Daily Horoscope App'),
          toolbarHeight: 85,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          backgroundColor: const Color.fromARGB(255, 184, 56, 99),
        ),
        drawer: Drawer(
          child: ListView(
            // padding: const EdgeInsets.all(5),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 184, 56, 99),
                ),
                child: Text('Drawer Menu'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home Screen'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () {
                  Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                },
              ),
            ],
          ),
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SignsList(),
            ],
          ),
        ));
  }
}
