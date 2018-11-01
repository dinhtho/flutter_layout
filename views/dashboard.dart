import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/authentication.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  UserInfo userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    String token = userInfo?.token ?? '';
    String email = userInfo?.user?.email ?? '';
    String name = userInfo?.user?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
          Text('Token: ' + token),
          Text('Email: ' + email),
          Text('Name: ' + name),
        ],
      )),
    );
  }

  loadLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final userInfoRaw = prefs.getString('userInfo');
    var jsonRaw = json.decode(userInfoRaw);
    var userInfo = UserInfo.fromJson(jsonRaw);
    if (userInfo != null) {
      setState(() {
        this.userInfo = userInfo;
      });
    }
  }
}
