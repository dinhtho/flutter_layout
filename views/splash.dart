import 'package:flutter/material.dart';
import 'login.dart';

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          });

    animationController0.forward();
  }

  @override
  void dispose() {
    animationController0.dispose();
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
