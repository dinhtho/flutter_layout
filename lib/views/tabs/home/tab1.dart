import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Tab1 extends StatefulWidget {
  @override
  State<Tab1> createState() => Tab1State();
}

class Tab1State extends State<Tab1> {
  var colors = [Colors.red, Colors.blue, Colors.green];
  final pageController = PageController();
  Timer timer;

  double page;
  int currentPos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = pageController.initialPage.toDouble();
    currentPos = pageController.initialPage;

    WidgetsBinding.instance.addPostFrameCallback((_) => autoScrollPageView());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    timer?.cancel();
  }

  void autoScrollPageView() {
    timer = Timer.periodic(
        const Duration(seconds: 2),
        (Timer t) => pageController.animateToPage(
            currentPos < 3 ? currentPos++ : 0,
            duration: const Duration(seconds: 1),
            curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 200,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    setState(() {
                      page = pageController.page;
                    });
                  }
                },
                child: PageView(
                  children: <Widget>[
                    buildPage(context, 0),
                    buildPage(context, 1),
                    buildPage(context, 2)
                  ],
                  controller: pageController,
                  onPageChanged: (pos) {
                    setState(() {
                      currentPos = pos;
                    });
                  },
                ),
              )),
          Container(
              height: 20,
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DotIndicator(page: page, position: 0),
                  DotIndicator(page: page, position: 1),
                  DotIndicator(page: page, position: 2),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, int position) {
    return Container(
        color: colors[position],
        child: Stack(
          children: <Widget>[
            Image(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              image: new AssetImage('assets/images/ic_text_basetax.png'),
            ),
            Center(child: Text('page' + position.toString()))
          ],
        ));
  }
}

class DotIndicator extends StatelessWidget {
  double width = 5;
  double height = 5;
  final double page;
  final int position;

  @override
  Widget build(BuildContext context) {
    double scale = max(0, 1 - (page - position).abs()) + 1.0;

    return Container(
      width: width * scale,
      height: height * scale,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
    );
  }

  DotIndicator({@required this.page, @required this.position});
}
