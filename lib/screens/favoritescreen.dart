import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zodiac_app/provaiders/signs_provaider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const routeName = '/favoritescreen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignsProv>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 56, 99),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Daily Horoscope App'),
        toolbarHeight: 85,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        backgroundColor: const Color.fromARGB(255, 184, 56, 99),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: ValueKey(provider.favorites[index].sign),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Text('Remove from favorites',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Confirmation"),
                          content: const Text(
                              "Are you sure you want to delete this item?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Delete")),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (DismissDirection direction) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content:
                          const Text('The sign is removed from favorites!'),
                      action:
                          SnackBarAction(label: 'Removed', onPressed: () {}),
                    ));
                    print('Remove item');
                    provider.deleteFavorite(provider.favorites[index]);
                  },
                  child: Card(
                      color: Colors.white10,
                      elevation: 5,
                      child: ExpansionTile(
                          leading: Text(
                              (provider.favorites[index].sign).toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                          title: Text(
                            DateFormat.MMMMd('en_US')
                                .format(provider.favorites[index].date),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                (provider.favorites[index].horoscope),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ])));
            }),
      ),
    );
  }
}
