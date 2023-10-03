import 'package:cryptoya/Models/AllCryptoModel.dart';
import 'package:cryptoya/network/AllApi.dart';
import 'package:cryptoya/network/ResponseModel.dart';
import 'package:flutter/material.dart';

class MarketViewProvider extends ChangeNotifier {
  AllApi allApi = AllApi();
  late AllCryptoModel datafuture;
  late ResponseModel state;
  var response;

  getCryptoData() async {
    state = ResponseModel.loading("is Loading...!");

    try {
      response = await allApi.getAllCryptoData();
      if (response.statusCode == 200) {
        datafuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(datafuture);
      } else {
        state = ResponseModel.error("Check Connection");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("Check Connection");
      notifyListeners();
    }
  }
}
