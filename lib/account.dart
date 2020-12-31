import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountState();
  }
}

class AccountState extends State<Account> {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Detail Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/health-shelter.appspot.com/o/800px-Image_created_with_a_mobile_phone.png?alt=media&token=5461c81c-7aae-4dd5-b43b-c8c7a82bad44"),
                  ),
                ),
              ),
            ),
            title: Text(
              "Quifar",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Member of Toughput Studio's Home",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text("Account"),
          ),
          ListTile(
            leading: Icon(
              Icons.lock_outline_rounded,
              color: Colors.black,
            ),
            title: Text(
              "Change Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            ),
            onTap: () => showBottomSheetPassword(context),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Alert(
                context: context,
                title: "Log Out",
                desc: "Are you sure you want to log out?",
                type: AlertType.info,
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Batal",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.grey,
                  ),
                  DialogButton(
                    onPressed: () async {},
                    child: Text(
                      "Setuju",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
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
                    color: Colors.blue,
                  ),
                  alertAlignment: Alignment.center,
                ),
              ).show();
            },
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.bottomCenter,
            child: Text("StarIot 2020"),
          ),
        ],
      ),
    );
  }

  void showBottomSheetPassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            child: Center(
                child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Text(
                    "Change Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 8) {
                            return "Password less than 8 characters";
                          }
                          return null;
                        },
                        controller: newPasswordController,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "New Password",
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 8) {
                            return "Password less than 8 characters";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      right: 50,
                      left: 50,
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {}
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
