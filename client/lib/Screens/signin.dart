// https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json
import 'package:flutter/material.dart';

//other files
import 'package:markus/Objects/user.dart';
import 'package:markus/cities.dart';
import 'package:markus/to_Database/dbMethods.dart';
import 'package:markus/values.dart';

//packages
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:email_validator/email_validator.dart';

final _formKey = GlobalKey<FormState>();

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  void _signin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      user.signupuser(_name, _email, _username, _password);
      Navigator.pop(context);
    } else
      print("Fail");
  }

  TextEditingController tc = TextEditingController();
  String _password, _name, _username, _email, _country, _city;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                child: Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                height: 500,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MailField(
                        onp: (val) {
                          _email = val;
                        },
                      ),
                      Field(
                        'Name',
                        onp: (val) {
                          _name = val;
                        },
                      ),
                      Field(
                        'Username',
                        onp: (val) {
                          _username = val;
                        },
                      ),
                      PassField(
                        name: 'New Password',
                        control: tc,
                        onp: (val) {
                          _password = val;
                        },
                      ),
                      ConfPassField(
                        tc: tc,
                        // control:_confirmPass,
                        // name: tc.text ?? '',
                        onp: (val) {
                          _password = val;
                        },
                      ),
                      // DropdownSearch<String>(
                      //     showSearchBox: true,
                      //     showClearButton: true,
                      //     mode: Mode.MENU,
                      //     showSelectedItem: true,
                      //     items: items,
                      //     hint: "City",
                      //     onChanged: (val) {
                      //       _city = val;
                      //     },
                      //     selectedItem: " "),
                      FlatButton(
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        color: colors[1],
                        onPressed: () {
                          // setState(() {});
                          _signin();
                        },
                      )
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: colors[2]),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class Field extends StatelessWidget {
  final String text;
  final Function onp;
  Field(this.text, {this.onp});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.person),
        hintText: text,
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onChanged: onp,
    );
  }
}

class MailField extends StatelessWidget {
  final Function onp;
  MailField({this.onp});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: EmailValidator(errorText: 'enter a valid email address'),
      onSaved: onp,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.mail),
        hintText: 'Email',
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      // onChanged: onp,
    );
  }
}

class PassField extends StatelessWidget {
  final TextEditingController control;
  final String name;
  final Function onp;
  PassField({this.name, this.onp, this.control});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      validator: MultiValidator([
        RequiredValidator(errorText: 'Password is required'),
        MinLengthValidator(8, errorText: 'Should be at least 8 digits long'),
        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
            errorText: 'Should have atleast one special character'),
        PatternValidator(r'(?=.*?[A-Z])',
            errorText: 'Should have atleast one uppercase character'),
        PatternValidator(r'(?=.*?[a-z])',
            errorText: 'Should have atleast one lowerercase character'),
        PatternValidator(r'(?=.*?[0-9])',
            errorText: 'Should have atleast one digit'),
      ]),
      onSaved: onp,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.lock),
        hintText: name,
        labelText: name,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      obscureText: true,
      // onChanged: onp,
    );
  }
}

class ConfPassField extends StatelessWidget {
  final tc;
  final Function onp;
  ConfPassField({this.onp, this.tc});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (password) {
        if (tc.text != password)
          return 'Password Mismatch';
        else
          return null;
      },
      onSaved: onp,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.lock),
        hintText: 'Confirm Password',
        labelText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      obscureText: true,
      // onChanged: onp,
    );
  }
}
