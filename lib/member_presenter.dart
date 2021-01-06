import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/constants.dart';
import 'package:iot_starbhak_client/member_contract.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberPresenter implements MemberContractPresenter {
  MemberContractView _memberContractView;

  MemberPresenter(this._memberContractView);

  @override
  Future<MemberModel> getMemberData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "member";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return MemberModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadMemberData() {
    getMemberData()
        .then((value) => _memberContractView.setOnSuccessMemberData(value))
        .catchError((error) => _memberContractView.setOnErrorMemberData(error));
  }
}
