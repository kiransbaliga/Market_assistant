import 'package:flutter/material.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/Screens/Survey/offers.dart';
import 'package:markus/Screens/Survey/quality.dart';

class Price extends StatefulWidget {
  final Rating rating;
  Price(this.rating);
  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
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
              'How much do you care about the price of a product?',
              style: TextStyle(fontSize: 20),
            ),
          )),
          Expanded(
            child: RadioListTile(
                activeColor: Colors.green,
                value: 1,
                groupValue: sel,
                title: Text(
                  "I don't care about money",
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
                  "Its not a huge factor for me",
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
                  "I always look for 'value for money'",
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
                            return Quality(widget.rating);
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
                        rat.price = sel;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return Offers(rat);
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
