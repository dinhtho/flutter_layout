import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/views/tabs/home/tab1.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleWidget(
            title: "Home",
            image: AssetImage('assets/images/ic_login.png'),
          ),
          Expanded(
            child: DefaultTabController(
                length: 3,
                child: Column(children: <Widget>[
                  Container(
                    color: Colors.lightBlueAccent,
                    child: TabBar(
                      indicatorColor: Colors.red,
                      tabs: [
                        TabCustom(
                            title: "Car",
                            image: AssetImage('assets/images/ic_login.png')),
                        TabCustom(
                            title: "Bus",
                            image: AssetImage('assets/images/ic_login.png')),
                        TabCustom(
                            title: "Bike",
                            image: AssetImage('assets/images/ic_login.png')),
                      ],
                    ),
                    height: 60.0,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Tab1(),
                        Icon(Icons.directions_transit),
                        Icon(Icons.directions_bike),
                      ],
                    ),
                  )
                ])),
          ),
        ],
      ),
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class TabCustom extends StatelessWidget {
  final ImageProvider image;
  final String title;

  TabCustom({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(width: 50, height: 20, child: Image(image: image)),
          Text(title)
        ],
      ),
    );
  }
}
