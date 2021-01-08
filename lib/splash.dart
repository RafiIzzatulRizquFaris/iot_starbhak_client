import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_starbhak_client/home.dart';
import 'package:iot_starbhak_client/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController textAnimationController;
  Animation textAnimation;

  @override
  void initState() {
    textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    );
    textAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: textAnimationController,
    );
    super.initState();
    textAnimationController.forward();
    movingToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: textAnimation,
                  axis: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Star",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "IOT",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textAnimationController.dispose();
  }

  movingToNextScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString(Constants.TOKEN);
    if (token == null) {
      Timer(
          Duration(
            seconds: 5,
          ), () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: Login(),
            type: PageTransitionType.topToBottom,
          ),
        );
      });
    } else {
      Timer(
        Duration(
          seconds: 5,
        ),
        () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: Home(),
              type: PageTransitionType.topToBottom,
            ),
          );
        },
      );
    }
  }
}
