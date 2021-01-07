import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/device_contract.dart';
import 'package:iot_starbhak_client/device_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class DevicePresenter implements DeviceContractPresenter {
  DeviceContractView deviceContractView;

  DevicePresenter(this.deviceContractView);

  @override
  Future<DeviceModel> getDeviceData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "device";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return DeviceModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadDeviceData() {
    getDeviceData()
        .then((value) => deviceContractView.setOnSuccessDeviceData(value))
        .catchError((error) => deviceContractView.setOnErrorDeviceData(error));
  }
}
