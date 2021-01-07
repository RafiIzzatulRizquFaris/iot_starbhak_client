import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/switch_device_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SwitchDevicePresenter implements SwitchDeviceContractPresenter {
  SwitchDeviceContractView switchDeviceContractView;

  SwitchDevicePresenter(this.switchDeviceContractView);

  @override
  Future<int> getSwitchDeviceData(String deviceId, String areaId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url =
        Constants.BASE_URL + "usage?device_id=$deviceId&area_id=$areaId";
    Client client = Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return response.statusCode;
  }

  @override
  loadSwitchDeviceData(String deviceId, String areaId) {
    getSwitchDeviceData(deviceId, areaId)
        .then((value) =>
            switchDeviceContractView.setOnSuccessSwitchDeviceData(value))
        .catchError((error) =>
            switchDeviceContractView.setOnErrorSwitchDeviceData(error));
  }
}
