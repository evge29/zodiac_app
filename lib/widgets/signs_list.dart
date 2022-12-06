import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zodiac_app/screens/detailscreen.dart';
//import 'dart:html';

import '../const/zodiac_sign.dart';
import '../model/zodiac_signs.dart';

class SignsList extends StatefulWidget {
  SignsList({Key? key}) : super(key: key);

  final List<Signs> Zodiac_sing = zodiac_sign;
  @override
  SignsListState createState() => SignsListState();
}

class SignsListState extends State<SignsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: widget.Zodiac_sing.length,
        padding: const EdgeInsets.only(left: 10, right: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 4,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  DetailsScreen.routeName,
                  arguments: zodiac_sign[index].name),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.white,
                  elevation: 5,
                  child: Column(children: <Widget>[
                    AspectRatio(
                      aspectRatio: 20.0 / 8.0,
                      child: Image.network(widget.Zodiac_sing[index].imageUrl),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  widget.Zodiac_sing[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                widget.Zodiac_sing[index].element,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Wrap(children: <Widget>[
                                Text(
                                  DateFormat.MMMMd('en_US').format(
                                      widget.Zodiac_sing[index].dateFrom),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat.MMMMd('en_US')
                                      .format(widget.Zodiac_sing[index].dateTo),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ])
                            ]))
                  ])));
        },
      ),
    );
  }
}
