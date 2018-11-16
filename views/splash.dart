import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
            child: Image(
      image: AssetImage('assets/images/ic_text_basetax.png'),
              width: 200.0,
    )));
  }
}
