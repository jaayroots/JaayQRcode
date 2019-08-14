import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Explicit

  double mySize = 250.0;
  Color myColors = Colors.red[300];

// Method

  Widget mySizeBox() {
    return SizedBox(
      width: 6.0,
      height: 12.0,
    );
  }

  Widget singUpButtom() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: myColors),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sing Up',
          style: TextStyle(color: myColors),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget singInButtom() {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red[300],
        child: Text(
          'Sing In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showButtom() {
    return Container(
      width: 250.0,
      child: Row(children: <Widget>[
        singInButtom(),
        mySizeBox(),
        singUpButtom(),
      ]),
    );
  }

  Widget showLogo() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: mySize,
        height: mySize,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Hello World QR Code',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.red[900],
        fontFamily: 'Bangers',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.white, Colors.grey], radius: 1.0,center: Alignment.center,)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showLogo(),
            mySizeBox(),
            showAppName(),
            showButtom()
          ],
        ),
      ),
    );
  }
}