import 'dart:ui';

//packages

//other files
import 'package:flutter/material.dart';
import 'package:markus/Screens/menu.dart';
import 'package:markus/values.dart';

class MySliverAppBar extends StatefulWidget {
  @override
  _MySliverAppBarState createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      actions: [
        FlatButton(
          shape: CircleBorder(),
          child: Hero(
            tag: 'account',
            child: Image(
              height: 30,
              width: 30,
              image: AssetImage('assets/accountImage.png'),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'account');
          },
        ),
        IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return Menu();
                  },
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeInBack, parent: animation);
                    return Align(
                      child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  }));
            })
      ],
      backgroundColor: colors[3],
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(250, 40))),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Hey, I am Markus",
          style: TextStyle(color: Colors.black),
        ),
        background: Container(
            child: Center(
                child: Icon(
          Icons.face_retouching_natural,
          color: colors[2],
          size: 80,
        ))),
      ),
    );
  }
}
