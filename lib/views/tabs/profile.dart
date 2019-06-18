import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/model/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  UserInfo userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleWidget(
            title: 'Layout Demo',
            image: AssetImage('assets/images/ic_login.png'),
          ),
          LinearLayoutWidget(),
          RelativeLayoutWidget()
        ],
      ),
    );
  }

  loadLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final userInfoRaw = prefs.getString('userInfo');
    if (userInfoRaw != null) {
      var jsonRaw = json.decode(userInfoRaw);
      var userInfo = UserInfo.fromJson(jsonRaw);
      if (userInfo != null) {
        setState(() {
          this.userInfo = userInfo;
        });
      }
    }
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class LinearLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 200,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.brown,
                    width: 10,
                    height: 30,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    color: Colors.deepPurple,
                    width: 20,
                    height: 30,
                  )
                ],
              ),
              color: Colors.red,
              height: double.infinity,
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text('2'),
              color: Colors.blue,
              height: double.infinity,
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text('3'),
              color: Colors.green,
              height: double.infinity,
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}

class RelativeLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text('1'),
              color: Colors.red,
              width: 50,
              height: 50,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text('2'),
              color: Colors.blue,
              width: 50,
              height: 50,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text('3'),
              color: Colors.red,
              width: 50,
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}
