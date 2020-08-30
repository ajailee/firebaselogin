import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_auth/Home.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}
class _LoginPageState extends State<LoginPage>{
  String _email,_password;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  GlobalKey<FormState> formKey= new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sign in")
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                // ignore: missing_return
                validator: (input){
                  if(!(input.isNotEmpty||input.contains('@'))){
                    return 'Enter the Valid Email Id';
                  }
                },
                onSaved: (input)=>_email=input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your Email Id',
                ),
              ),
              TextFormField(
                // ignore: missing_return
                validator: (input){
                  if(input.length<8){
                    return 'weak password';
                  }
                },
                onSaved: (input)=>_password=input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your Password',

                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed:
                  signIn,
                child: Text('Sign in')
              ),
            ],
          )
      )
    );
  }
Future<void> signIn() async {
    // TODO Vaildate

  final _formState = formKey.currentState;
  if(_formState.validate()){
    // FireBase Auth
    _formState.save();
    try{
      UserCredential user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      //navigae to page
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(user: user)));
    }catch(e){
          print(e.message);
    }
  }
}
}