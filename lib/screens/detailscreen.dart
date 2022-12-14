import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zodiac_app/model/zodiac_signs_api.dart';
import 'package:provider/provider.dart';
import 'package:zodiac_app/provaiders/signs_provaider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/detailscreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<SignsApi> futureSignData;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      var provaider = Provider.of<SignsProv>(context, listen: true);
      final signName = ModalRoute.of(context)!.settings.arguments as String;
      futureSignData = provaider.fetchData(signName);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Widget _buildDetails(SignsApi sign) {
    return Card(
      color: Colors.white10,
      elevation: 5,
      child: ListTile(
        leading: Text((sign.sign).toUpperCase(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontStyle: FontStyle.italic)),
        title: Text(
          sign.horoscope,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        subtitle: Text(
          DateFormat.MMMMd('en_US').format(sign.date),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provaider = Provider.of<SignsProv>(context, listen: true);
    final signName = ModalRoute.of(context)!.settings.arguments as String;
    print(signName);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 184, 56, 99),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Daily Horoscope App"),
          toolbarHeight: 85,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          backgroundColor: const Color.fromARGB(255, 184, 56, 99),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                provaider.toggleFavorite();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  content: const Text('The sign is added to favourites!'),
                  action: SnackBarAction(label: 'Added', onPressed: () {}),
                ));
              },
              icon: provaider.isExist(provaider.lastFetched)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
            )
          ],
        ),
        body: Column(children: [
          Center(
            child: FutureBuilder<SignsApi>(
              future: futureSignData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildDetails(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              },
            ),
          ),
        ]));
  }
}
