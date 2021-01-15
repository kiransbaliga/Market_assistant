import 'package:flutter/material.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/Screens/Survey/brand.dart';
import 'package:markus/Screens/Survey/price.dart';

class Quality extends StatefulWidget {
  final Rating rating;
  Quality(this.rating);
  @override
  _QualityState createState() => _QualityState();
}

class _QualityState extends State<Quality> {
  int sel = 0;
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
              'How much do you care about the Quality of a product?',
              style: TextStyle(fontSize: 20),
            ),
          )),
          Expanded(
            child: RadioListTile(
                activeColor: Colors.green,
                value: 1,
                groupValue: sel,
                title: Text(
                  "I don't care about quality",
                  style: TextStyle(fontSize: 20),
                ),
                onChanged: (val) {
                  setState(() {
                    sel = 1;
                  });
                }),
          ),
          Expanded(
            child: RadioListTile(
                activeColor: Colors.green,
                value: 2,
                groupValue: sel,
                title: Text(
                  "Sometimes, I worried about the quality of a product",
                  style: TextStyle(fontSize: 20),
                ),
                onChanged: (val) {
                  setState(() {
                    sel = 2;
                  });
                }),
          ),
          Expanded(
            child: RadioListTile(
                activeColor: Colors.green,
                value: 3,
                groupValue: sel,
                title: Text(
                  "I always consider the quality of a product",
                  style: TextStyle(fontSize: 20),
                ),
                onChanged: (val) {
                  setState(() {
                    sel = 3;
                  });
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                      padding: EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      child: Text('Previous'),
                      color: Colors.grey[300],
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return Brand(widget.rating);
                          },
                        ));
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
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        Rating rat = widget.rating;
                        rat.quality = sel;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return Price(rat);
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
