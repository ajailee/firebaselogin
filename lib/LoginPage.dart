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
class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
            title: Text("Sign in"),
          backgroundColor: Colors.orange,
        ),
        body: Form(

            key: formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (input) {
                    if (!(input.contains('@'))) {
                      return 'Enter the Valid Email Id';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email Id',
                  ),
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if (input.length < 8) {
                      return 'weak password';
                    }
                  },
                  onSaved: (input) => _password = input,
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
    if (_formState.validate()) {
      // FireBase Auth
      _formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Incorrect email or password'),
                        ),
                        SizedBox(
                          width: 320.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    }
  }
}