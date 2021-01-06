import 'dart:convert';

import 'package:http/http.dart';
import 'package:iot_starbhak_client/login_contract.dart';
import 'package:iot_starbhak_client/login_model.dart';

class LoginPresenter implements LoginContractPresenter {
  LoginContractView _loginContractView;

  LoginPresenter(this._loginContractView);

  @override
  Future<LoginModel> getLoginData(String email, String password) async {
    Client client = Client();
    String url = "iot.starbhak.store/api/login";
    final response = await client.post(
      url,
      body: {
        "email" : email,
        "password" : password,
      },
    );
    return LoginModel.fromJson(jsonDecode(response.body));
  }

  @override
  loadLoginData(String email, String password) {
    getLoginData(email, password)
        .then((value) => _loginContractView.setOnSuccessLoginData(value))
        .catchError((error) => _loginContractView.setOnErrorLoginData(error));
  }
}
