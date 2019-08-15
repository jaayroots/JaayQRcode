import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Exeplicit

  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method

  @override
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
  }

  Widget showLogin() {
    return Text('Login By $nameLogin');
  }

  Widget showAppname() {
    return Text(
      'Ung QR code',
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 80.0,
      width: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myDrawerHrader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.white, Colors.grey],radius: 1.0),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppname(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[myDrawerHrader()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('Hello World'),
      drawer: myDrawer(),
    );
  }
}
