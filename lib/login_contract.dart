import 'package:iot_starbhak_client/login_model.dart';

class LoginContractView{
  setOnSuccessLoginData(LoginModel loginModel) {}

  setOnErrorLoginData(error) {}
}

class LoginContractPresenter{
  getLoginData(String email, String password) {}
  loadLoginData(String email, String password) {}
}