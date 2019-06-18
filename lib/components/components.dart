import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final ImageProvider image;
  final String title;

  TitleWidget({@required this.image, @required this.title});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(color: Colors.blue, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 20.0, // has the effect of softening the shadow
          spreadRadius: 6.0, // has the effect of extending the shadow
          offset: Offset(
            10.0, // horizontal, move right 10
            1.0, // vertical, move down 10
          ),
        )
      ]),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.only(top: statusBarHeight),
      height: 50.0,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Image(
              image: image,
              height: double.infinity,
            ),
          ),
          Align(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
    ;
  }
}
