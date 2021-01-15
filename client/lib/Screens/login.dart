import 'package:flutter/material.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/to_Database/dbMethods.dart';
import 'package:markus/values.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _login() {
    print('check 1');
    user.loginuser(_email, _password);
    Navigator.pop(context);
  }

  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                child: Center(
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: colors[3], borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        labelText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onChanged: (val) {
                        _email = val;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onChanged: (val) {
                        _password = val;
                      },
                      obscureText: true,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                      color: colors[1],
                      onPressed: () {
                        _login();
                      },
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New Here?"),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Sign in here",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: colors[2]),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'signin');
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
