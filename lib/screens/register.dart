import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaay_qr_code/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit

  Color nameColor = Color.fromARGB(0xFF, 0xc2, 0x18, 0x5b);
  Color emailColor = Colors.orange;
  Color passwordColor = Colors.blueGrey;
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  // Method

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: nameColor),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: nameColor),
        hintText: 'English Only',
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: nameColor,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Display Email :',
        labelStyle: TextStyle(color: emailColor),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: emailColor),
        hintText: 'You@email.com',
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: emailColor,
        ),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please keep Email Format';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Password :',
        labelStyle: TextStyle(color: passwordColor),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: passwordColor),
        hintText: 'More 6 Charactor',
        icon: Icon(
          Icons.lock_outline,
          size: 36.0,
          color: passwordColor,
        ),
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Please Type Password More 6 charactor';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString, email = $emailString, password = $passwordString');
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      print('Response = $response');
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }


  Future<void> setupDisplayName()async{

    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nameString;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);

  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var test = AlertDialog(
          title: ListTile(
            leading: Icon(Icons.error_outline),
            title: Text(
              title,
              style: TextStyle(color: Colors.red),
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
        return test;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: Colors.grey[600],
        title: Text('Register'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(
            top: 60.0,
            left: 30.0,
            right: 30.0,
          ),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
