import 'package:flutter/material.dart';

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
          print('name = $nameString, email = $emailString, password = $passwordString');
        }
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
