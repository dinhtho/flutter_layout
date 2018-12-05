import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../model/authentication.dart';

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
    String token = userInfo?.token ?? '';
    String email = userInfo?.user?.email ?? '';
    String name = userInfo?.user?.name ?? '';
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://avatars0.githubusercontent.com/u/20509711?s=40&v=4'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Text(name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                      )
                    ],
                  ),
                ),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: Center(
        child: Text("Sample Text"),
      ),
    ));
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

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
