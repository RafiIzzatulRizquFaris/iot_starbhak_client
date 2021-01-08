import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/history_contract.dart';
import 'package:iot_starbhak_client/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class HistoryPresenter implements HistoryContractPresenter {
  HistoryContractView _historyContractView;

  HistoryPresenter(this._historyContractView);

  @override
  Future<HistoryModel> getHistoryData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "history";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return HistoryModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadHistoryData() {
    getHistoryData()
        .then((value) => _historyContractView.setOnSuccessHistoryData(value))
        .catchError(
            (error) => _historyContractView.setOnErrorHistoryData(error));
  }
}
