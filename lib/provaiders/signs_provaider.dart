import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zodiac_app/model/zodiac_signs_api.dart';
import 'package:zodiac_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class SignsProv extends ChangeNotifier {
  List<SignsApi> _favourites = [];
  SignsApi? lastFetched = null;

  Future<SignsApi> fetchData(String signName) async {
    final url = Uri.https(
        Constants.baseUrl, "${Constants.baseUrl1}/${signName.toLowerCase()}");

    var data = await http.get(url);
    final response = json.decode(data.body);
    final signs = SignsApi.fromJson(response);
    lastFetched = signs;
    notifyListeners();
    print(response);

    return signs;
  }

  void toggleFavorite() {
    if (lastFetched == null) return;
    final isExist = _favourites.where((item) =>
        item.date.isAtSameMomentAs(lastFetched!.date) &&
        item.sign == lastFetched!.sign);

    if (isExist.isNotEmpty) {
      _favourites.remove(lastFetched);
    } else {
      _favourites.add(lastFetched!);
    }
    notifyListeners();
  }

  bool isExist(SignsApi? sign) {
    if (sign == null) return false;

    final isExist = _favourites.contains(sign);
    return isExist;
  }

  void deleteFavorite(SignsApi sign) {
    if (_favourites.contains(sign)) _favourites.remove(sign);

    notifyListeners();
  }

  List<SignsApi> get favorites {
    return [..._favourites];
  }
}
