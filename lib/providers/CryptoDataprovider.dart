import 'package:cryptoya/Models/AllCryptoModel.dart';
import 'package:cryptoya/network/ResponseModel.dart';
import 'package:cryptoya/network/AllApi.dart';
import 'package:flutter/material.dart';

class CryptoDataProvider extends ChangeNotifier {
  AllApi allApi = AllApi();

  late AllCryptoModel datafuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading("Please Wait!!!");

    try {
      response = await allApi.getTopMarketCapData();
      if (response.statusCode == 200) {
        datafuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(datafuture);
      } else {
        state = ResponseModel.error("Error...ComeBackLater!");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error(e.toString());
      notifyListeners();
    }
  }
}
