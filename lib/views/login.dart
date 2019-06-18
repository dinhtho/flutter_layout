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
  final TextEditingController emailCl = TextEditingController();
  final TextEditingController pwCl = TextEditingController();
  final FocusNode pwFocusNode = FocusNode();

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(children: <Widget>[
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                    Image.asset('assets/images/ic_text_basetax.png',
                        width: 150.0, height: 40.0),
                    Image.asset('assets/images/ic_login.png',
                        width: 50.0, height: 150.0),
                    Column(children: <Widget>[
                      Text("Email",
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontStyle: FontStyle.italic,
                              fontSize: 10.0,
                              color: Colors.black)),
                      Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.black)),
                          child: TextField(
                              controller: emailCl,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (String value) =>
                                  FocusScope.of(context)
                                      .requestFocus(pwFocusNode),
                              decoration: InputDecoration(
                                  hintText: 'Please enter email',
                                  border: InputBorder.none)))
                    ], crossAxisAlignment: CrossAxisAlignment.stretch),
                    Column(children: <Widget>[
                      Text("Password",
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontStyle: FontStyle.italic,
                              fontSize: 10.0,
                              color: Colors.black)),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.black)),
                        child: TextField(
                            controller: pwCl,
                            textInputAction: TextInputAction.done,
                            focusNode: pwFocusNode,
                            obscureText: true,
                            onSubmitted: (String value) => login(context),
                            decoration: InputDecoration(
                                hintText: 'Please enter password',
                                border: InputBorder.none)),
                      )
                    ], crossAxisAlignment: CrossAxisAlignment.stretch),
                    GestureDetector(
                        onTap: () {
                          login(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          margin: const EdgeInsets.only(
                              top: 50.0, left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: Text(
                            "Sign In",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          )),
                        )),
                  ])),
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: 10.0, top: 40.0, right: 10.0, bottom: 20.0)),
              showLoading
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      width: 10.0,
                      height: 10.0)
                  : Container()
            ])));
  }

  login(BuildContext context) async {
    setState(() {
      showLoading = true;
    });
//    var response = await NetworkProvider.post(
//        'login',  LoginRequest(emailCl.text, pwCl.text, true).toJson());
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
