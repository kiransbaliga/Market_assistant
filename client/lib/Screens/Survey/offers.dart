import 'package:flutter/material.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/Screens/Survey/price.dart';
import 'package:markus/to_Database/dbMethods.dart';

class Offers extends StatefulWidget {
  final Rating rating;
  Offers(this.rating);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
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
              'How much do you care about the available offers?',
              style: TextStyle(fontSize: 20),
            ),
          )),
          Expanded(
            child: RadioListTile(
                activeColor: Colors.green,
                value: 1,
                groupValue: sel,
                title: Text(
                  "I don't care about offers",
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
                  "Only if it is a huge deal!",
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
                  "I always look for offers",
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
                            return Price(widget.rating);
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
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        Rating rat = widget.rating;
                        rat.offers = sel;
                        print(
                            '${rat.brand}${rat.price}${rat.quality}${rat.offers}');
                        user.submitrating(rat);
                        Navigator.pop(context);
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
