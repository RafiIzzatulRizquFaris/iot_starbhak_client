import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_starbhak_client/home.dart';
import 'package:iot_starbhak_client/login_contract.dart';
import 'package:iot_starbhak_client/login_model.dart';
import 'package:iot_starbhak_client/login_presenter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> implements LoginContractView {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Constants constants;
  LoginPresenter loginPresenter;
  bool obscureText = true;
  bool loadingLogin = false;

  LoginState(){
    loginPresenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadingLogin
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // Image.asset(
                      //   'assets/images/logo_ap.png',
                      //   height: 120,
                      //   width: 120,
                      // ),
                      Icon(
                        Icons.sensor_door_rounded,
                        color: Colors.blue,
                        size: 100,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Welcome!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Enter your login data to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        validator: (value) {
                          if (EmailValidator.validate(value)) {
                            return null;
                          }
                          return "Incorrect email entered";
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 8) {
                            return "Password less than 8 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              if (obscureText) {
                                setState(() {
                                  obscureText = false;
                                });
                              } else {
                                setState(() {
                                  obscureText = true;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.all(8)),
                          shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue),
                        ),
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              loadingLogin = true;
                            });
                            loginPresenter.loadLoginData(emailController.text.trim().toString(), passwordController.text.trim().toString());
                          } else {
                            // TODO: error
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account yet? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Sign up now",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     child: RegisterScreen(),
                              //     type: PageTransitionType.rightToLeft,
                              //     duration: Duration(
                              //       seconds: 250,
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  setOnErrorLoginData(error) async {
    setState(() {
      loadingLogin = false;
    });
    print(error);
    Alert(
      context: context,
      title: "Failed to Login",
      desc: "Please Check Your Internet Connection",
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.center,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }

  @override
  setOnSuccessLoginData(LoginModel loginModel) async {
    if (loginModel.success){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(Constants.TOKEN, loginModel.result.member_token);
      preferences.setString(Constants.NAME, loginModel.result.username);
      setState(() {
        loadingLogin = false;
      });
      Navigator.push(
        context,
        PageTransition(
          child: Home(),
          type: PageTransitionType.bottomToTop,
          duration: Duration(seconds: 1),
        ),
      );
    } else if (!loginModel.success){
      setState(() {
        loadingLogin = false;
      });
      Alert(
        context: context,
        title: "Failed to Login",
        desc: loginModel.message,
        type: AlertType.warning,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
        style: AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          descStyle: TextStyle(fontWeight: FontWeight.bold),
          descTextAlign: TextAlign.center,
          animationDuration: Duration(milliseconds: 400),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          titleStyle: TextStyle(
            color: Colors.red,
          ),
          alertAlignment: Alignment.center,
        ),
      ).show();
    }
  }
}
