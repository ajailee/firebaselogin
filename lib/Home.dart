import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({Key key, this.user}) : super(key: key);
  final UserCredential user;

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    int index = widget.user.user.email.indexOf('@');
    final String name = widget.user.user.email.substring(0,index);
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
         title: Text('welcome ')

     ),
     body:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         Card(
           color: Colors.lightBlue,
           child: Text('Hi ${name} welcome !!!',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
         ),
       ],
     )

   );
  }

}