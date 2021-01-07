import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/get_usage_contract.dart';
import 'package:iot_starbhak_client/get_usage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class GetUsagePresenter implements GetUsageContractPresenter {
  GetUsageContractView _getUsageContractView;

  GetUsagePresenter(this._getUsageContractView);

  @override
  Future<GetUsageModel> getGetUsageData() async {
    print("masuk");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "usage";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return GetUsageModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadGetUsageData() {
    print("masuk load");
    getGetUsageData()
        .then((value) => _getUsageContractView.setOnSuccessGetUsageData(value))
        .catchError(
            (error) => _getUsageContractView.setOnErrorGetUsageData(error));
  }
}
