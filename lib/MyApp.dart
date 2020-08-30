import 'package:flutter/material.dart';
import 'package:login_auth/LoginPage.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}