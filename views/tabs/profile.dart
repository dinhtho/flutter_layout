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
          child: Column(
            children: <Widget>[
              _ContactCategory(
                icon: Icons.contact_mail,
                children: <Widget>[
                  _ContactItem(
                    icon: Icons.email,
                    tooltip: 'Send personal e-mail',
                    onPressed: () {},
                    lines: const <String>[
                      'ali_connors@example.com',
                      'Personal',
                    ],
                  ),
                  _ContactItem(
                    icon: Icons.email,
                    tooltip: 'Send work e-mail',
                    onPressed: () {},
                    lines: const <String>[
                      'aliconnors@example.com',
                      'Work',
                    ],
                  ),
                ],
              ),
              _ContactCategory(
                icon: Icons.contact_mail,
                children: <Widget>[
                  _ContactItem(
                    icon: Icons.email,
                    tooltip: 'Send personal e-mail',
                    onPressed: () {},
                    lines: const <String>[
                      'ali_connors@example.com',
                      'Personal',
                    ],
                  ),
                  _ContactItem(
                    icon: Icons.email,
                    tooltip: 'Send work e-mail',
                    onPressed: () {},
                    lines: const <String>[
                      'aliconnors@example.com',
                      'Work',
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class _ContactCategory extends StatelessWidget {
  const _ContactCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: themeData.dividerColor))),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: Icon(icon, color: themeData.primaryColor)),
              Expanded(child: Column(children: children))
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  _ContactItem({Key key, this.icon, this.lines, this.tooltip, this.onPressed})
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map<Widget>((String line) => Text(line))
        .toList();
    columnChildren.add(Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren))
    ];
    if (icon != null) {
      rowChildren.add(SizedBox(
          width: 72.0,
          child: IconButton(
              icon: Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed)));
    }
    return MergeSemantics(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren)),
    );
  }
}
