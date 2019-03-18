import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/network_provider.dart';
import '../model/authentication.dart';
import './dashboard.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final TextEditingController emailCl = new TextEditingController();
  final TextEditingController pwCl = new TextEditingController();
  final FocusNode pwFocusNode = FocusNode();

  bool showLoading = false;

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
        controller: emailCl,
        textInputAction: TextInputAction.done,
        onSubmitted: (String value) =>
            FocusScope.of(context).requestFocus(pwFocusNode),
        decoration: InputDecoration(
            hintText: 'Please enter email', border: InputBorder.none));

    var emailTextFieldBox = new Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          border: new Border.all(color: Colors.black)),
      child: emailTextField,
    );

    var emailColumn = new Column(
        children: <Widget>[emailText, emailTextFieldBox],
        crossAxisAlignment: CrossAxisAlignment.stretch);

    var pwText = new Text("Password",
        style: new TextStyle(
            fontFamily: 'WorkSans',
            fontStyle: FontStyle.italic,
            fontSize: 10.0,
            color: Colors.black));

    var pwTextField = new TextField(
        controller: pwCl,
        textInputAction: TextInputAction.done,
        focusNode: pwFocusNode,
        obscureText: true,
        onSubmitted: (String value) => login(context),
        decoration: InputDecoration(
            hintText: 'Please enter password', border: InputBorder.none));

    var pwTextFieldBox = new Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          border: new Border.all(color: Colors.black)),
      child: pwTextField,
    );

    var pwColumn = new Column(
        children: <Widget>[pwText, pwTextFieldBox],
        crossAxisAlignment: CrossAxisAlignment.stretch);

    var loginBox = new GestureDetector(
        onTap: () {
          login(context);
        },
        child: new Container(
          width: double.infinity,
          height: 40.0,
          margin: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          decoration: new BoxDecoration(
              color: Colors.green,
              borderRadius: new BorderRadius.circular(5.0)),
          child: new Center(
              child: new Text(
            "Sign In",
            style: new TextStyle(color: Colors.white, fontSize: 15.0),
          )),
        ));

    var progressBar = new Container(
        child: showLoading
            ? Container(
                child: new Container(
                    alignment: Alignment.center,
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    width: 10.0,
                    height: 10.0),
                height: double.infinity,
                width: double.infinity,
                color: Colors.black38,
              )
            : null);

    return new Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: new Stack(children: <Widget>[
              new Container(
                  child: new SingleChildScrollView(
                      child: new Column(children: <Widget>[
                    imageLogo,
                    imageLogin,
                    emailColumn,
                    pwColumn,
                    loginBox,
                  ])),
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: 10.0, top: 40.0, right: 10.0, bottom: 20.0)),
              progressBar
            ])));
  }

  login(BuildContext context) async {
    setState(() {
      showLoading = true;
    });
//    var response = await NetworkProvider.post(
//        'login', new LoginRequest(emailCl.text, pwCl.text, true).toJson());
    setState(() {
      showLoading = false;
    });

//    if (!(response is Exception) && response['data'] != null) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      await prefs.setString('userInfo', json.encode(response['data']));
//    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}
