import 'package:flutter/material.dart';
import '../services/network_provider.dart';
import '../model/authentication.dart';

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
  final TextEditingController emailCl = new TextEditingController();
  final TextEditingController pwCl = new TextEditingController();
  final FocusNode pwFocusNode = FocusNode();

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
        textInputAction: TextInputAction.next,
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

    return new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new Container(
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              imageLogo,
              imageLogin,
              emailColumn,
              pwColumn,
              loginBox
            ])),
            color: Colors.white,
            padding: EdgeInsets.only(
                left: 10.0, top: 40.0, right: 10.0, bottom: 20.0)));
  }

  login(BuildContext context) async {
    Map response = await NetworkProvider.post(
        'login', new LoginRequest(emailCl.text, pwCl.text, true).toJson());

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(response['data'].toString()),
    ));
  }
}
