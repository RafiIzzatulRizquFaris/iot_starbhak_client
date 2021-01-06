import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/area_contract.dart';
import 'package:iot_starbhak_client/get_area_model.dart';
import 'package:iot_starbhak_client/submit_area_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AreaPresenter
    implements GetAreaContractPresenter, SubmitAreaContractPresenter {
  GetAreaContractView getAreaContractView;
  SubmitAreaContractView submitAreaContractView;

  AreaPresenter({this.getAreaContractView, this.submitAreaContractView});

  SharedPreferences preferences;

  @override
  Future<GetAreaModel> getAreaData() async {
    preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "area";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return GetAreaModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadAreaData() {
    getAreaData()
        .then((value) => getAreaContractView.setOnSuccessGetAreaData(value))
        .catchError(
            (error) => getAreaContractView.setOnErrorGetAreaData(error));
  }

  @override
  Future<SubmitAreaModel> submitAreaData({String name}) async {
    preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "area";
    Client client = Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
      body: {
        "name": name,
      },
    );
    return SubmitAreaModel.fromJson(jsonDecode(response.body));
  }

  @override
  submitLoadAreaData({String name}) {
    submitAreaData(name: name)
        .then(
            (value) => submitAreaContractView.setOnSuccessSubmitAreaData(value))
        .catchError(
            (error) => submitAreaContractView.setOnErrorSubmitAreaData(error));
  }
}
