import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaay_qr_code/screens/first_page.dart';
import 'package:jaay_qr_code/screens/home.dart';
import 'package:jaay_qr_code/screens/second_page.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Exeplicit

  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = FristPage();

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
    return Text(
      'Login By $nameLogin',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget showAppname() {
    return Text(
      'Ung QR code',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
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
        image: DecorationImage(
            image: AssetImage('images/land.jpg'), fit: BoxFit.fill),
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

  Widget pageFirstMenu() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('First Page'),
      subtitle: Text('นี่แสดงหน้า List View'),
      onTap: () {
        setState(() {
         myWidget = FristPage(); 
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget pageSecondMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Second Page'),
      onLongPress: () {},
      onTap: () {
        setState(() {
         myWidget = SecondPage(); 
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget pageSingoutMenu() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sing Out'),
      onTap: () {
        Navigator.of(context).pop();
        mySingOut();
      },
    );
  }

  Future<void> mySingOut() async {
    await firebaseAuth.signOut().then(
      (reponse) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

//Line
  Widget myDivider() {
    return Divider();
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myDrawerHrader(),
          pageFirstMenu(),
          myDivider(),
          pageSecondMenu(),
          myDivider(),
          pageSingoutMenu(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: myWidget,
      drawer: myDrawer(),
    );
  }
}
