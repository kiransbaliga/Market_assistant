import 'package:flutter/material.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/Screens/Survey/brand.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 14),
            child: Text(
              'For better recommedations, we would like to know more about you. Can we do a survey?',
              style: TextStyle(fontSize: 20),
            ),
          )),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                      padding: EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      child: Text('Not now'),
                      color: Colors.grey[300],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                      padding: EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      child: Text(
                        'Yeah Sure',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return Brand(Rating());
                          },
                        ));
                      },
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
