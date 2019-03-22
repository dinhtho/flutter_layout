import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/authentication.dart';
import './dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashState();
}

class SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController animationController0;
  AnimationController animationController1;
  Animation<double> scalingAnimation;
  Animation<double> animationFadeIn;
  Animation<double> moveUpAnimation;
  Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    animationController0 = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    animationController1 = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    // scaling animation
    scalingAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController0, curve: Curves.elasticOut))
      ..addListener(() => this.setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          animationController1.forward();
        }
      });

    animationFadeIn = Tween(begin: 0.0, end: 1.0).animate(animationController0);

    moveUpAnimation =
        new Tween(begin: 0.0, end: -1.0).animate(animationController1);

    rotationAnimation =
        Tween(begin: 0.0, end: 360.0).animate(animationController1)
          ..addListener(() => this.setState(() {}))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              checkLogin();
            }
          });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => animationController0.forward());
  }

  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    var navigatedScreen;
    final userInfoRaw = prefs.getString('userInfo');

    if (userInfoRaw != null) {
      var jsonRaw = json.decode(userInfoRaw);
      var userInfo = UserInfo.fromJson(jsonRaw);
      print(userInfo.token);
      navigatedScreen = DashboardScreen();
    } else {
      navigatedScreen = LoginScreen();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => navigatedScreen),
    );
  }

  @override
  void dispose() {
    animationController0.dispose();
    animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0.0, moveUpAnimation.value),
        child: Transform.rotate(
            origin: Offset(0.0, 100.0),
            angle: rotationAnimation.value,
            child: Opacity(
                opacity: animationFadeIn.value,
                child: Image(
                  image: AssetImage('assets/images/ic_text_basetax.png'),
                  width: scalingAnimation.value * 200.0,
                  height: scalingAnimation.value * 100.0,
                ))));
  }
}
