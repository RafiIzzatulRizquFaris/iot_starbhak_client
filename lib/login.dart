import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_starbhak_client/home.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool loadingLogin = false;

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
                          Navigator.push(
                            context,
                            PageTransition(
                              child: Home(),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // if (formKey.currentState.validate()) {
                          //   setState(() {
                          //     loadingLogin = true;
                          //   });
                          // } else {
                          //   // TODO: error
                          // }
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
}
