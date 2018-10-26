import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.green,
        ),
        home: new Scaffold(body: new MainPage()));
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imageLogo = new Image(
        image: new AssetImage('assets/images/ic_text_basetax.png'),
        width: 150.0,
        height: 40.0);

    var imageLogin = new Image(
        image: new AssetImage('assets/images/ic_login.png'),
        width: 50.0,
        height: 150.0);

    var emailText = new Text("Email",
        style: new TextStyle(
            fontFamily: 'WorkSans',
            fontStyle: FontStyle.italic,
            fontSize: 10.0,
            color: Colors.black));
    var emailTextField = new TextField(
        decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      hintText: 'Please enter email',
    ));
    var emailColumn = new Column(
        children: <Widget>[emailText, emailTextField],
        crossAxisAlignment: CrossAxisAlignment.stretch);

    return new Container(
        child:
            new Column(children: <Widget>[imageLogo, imageLogin, emailColumn]),
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0, bottom: 20.0));
  }
}
