import 'package:cryptoya/Models/userModel.dart';
import 'package:cryptoya/network/AllApi.dart';
import 'package:cryptoya/network/ResponseModel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AllApi allApi = AllApi();
  late dynamic datafuture;
  late ResponseModel registerstatus;
  var loginstate;
  var error;
  var respone;

  CallRegisterApi(name, email, password) async {
    registerstatus = ResponseModel.loading("isLoading");
    notifyListeners();

    try {
      respone = await allApi.callRegisterApi(name, email, password);
      if (respone.statusCode == 201) {
        datafuture = UserModel.fromJson(respone.data);
        registerstatus = ResponseModel.complete(datafuture);
      } else if (respone.statusCode == 200) {
        datafuture = UserModel.fromJson(respone.data);
        registerstatus = ResponseModel.error("Eroor!");
      }
      notifyListeners();
    } catch (e) {
      registerstatus = ResponseModel.error("Error!Try Again Later!!!");
    }
  }
}
