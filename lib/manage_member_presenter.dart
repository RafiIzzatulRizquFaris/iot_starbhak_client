import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/constants.dart';
import 'package:iot_starbhak_client/manage_member_contract.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageMemberPresenter implements ManageMemberContractPresenter {
  ManageMemberContractView manageMemberContractView;

  ManageMemberPresenter(this.manageMemberContractView);

  @override
  Future<MemberModel> getMemberData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "member";
    Client client = Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    return MemberModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadMemberData() {
    getMemberData()
        .then((value) => manageMemberContractView.setOnSuccessMemberData(value))
        .catchError(
            (error) => manageMemberContractView.setOnErrorMemberData(error));
  }

  @override
  Future<int> addMemberData(
      String email, String password, String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "member";
    Client client = Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
      body: {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    return response.statusCode;
  }

  @override
  loadAddMemberData(String email, String password, String username) {
    addMemberData(email, password, username)
        .then((value) => manageMemberContractView.setOnSuccessAddMember())
        .catchError(
            (error) => manageMemberContractView.setOnErrorMemberData(error));
  }

  @override
  Future<int> deleteMemberData(String clientId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = Constants.BASE_URL + "member/" + clientId;
    Client client = Client();
    final response = await client.delete(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + preferences.getString(Constants.TOKEN),
      },
    );
    print(response.statusCode);
    return response.statusCode;
  }

  @override
  loadDeleteMemberData(String clientId) {
    deleteMemberData(clientId)
        .then((value) => manageMemberContractView.setOnSuccessAddMember())
        .catchError(
            (error) => manageMemberContractView.setOnErrorMemberData(error));
  }
}
