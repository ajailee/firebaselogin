import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/LoginPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'SignUp.dart';

class welcomepage extends StatefulWidget {
  @override
  welcomepageState createState() =>  welcomepageState();

}
class  welcomepageState extends State<welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text("Welcome"),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            color: Colors.lime,
            onPressed: navigateToSignIn,
            child: Text('Sign in'),
          ),
          RaisedButton(
              color: Colors.brown ,
              onPressed: navigateToSignup,
              child:Text('Sign up'),
              ),

        ],
    ),
    );
  }
  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),fullscreenDialog: true));
  }
  void navigateToSignup(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
  }
}

