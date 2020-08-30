import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpState createState () =>SignUpState();


}
class SignUpState extends State<SignUp> {
  String _email, _password;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber,
        appBar: AppBar(title: Text("Sign up"),
            backgroundColor: Colors.amberAccent
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
                    if (!( input.contains('@'))) {
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
                    signUp,
                    child: Text('Sign up')
                ),
              ],
            )
        )
    );
  }

  Future<void> signUp() async {
    // TODO Vaildate

    final _formState = formKey.currentState;
    if (_formState.validate()) {
        _formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.user.sendEmailVerification();
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
                              hintText: 'verify the email with 24 hrs'),
                        ),
                        SizedBox(
                          width: 320.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                              hintText: 'The email address is already in used'),
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






