import 'package:flutter/material.dart';

//packages

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Payment Methods'),
            leading: Icon(Icons.payment),
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
