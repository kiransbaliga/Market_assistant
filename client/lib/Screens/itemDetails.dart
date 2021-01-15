import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/Screens/cart.dart';

class ItemDetail extends StatelessWidget {
  final Item _item;
  ItemDetail(this._item);
  Color getcolor() {
    double d = _item.getrating();
    if (d < 2) return Colors.red;
    if (d < 3.5) return Colors.orange;
    return Colors.green;
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.width / 1.75,
                child: Center(
                  child: Image.network(
                    _item.image,
                    fit: BoxFit.contain,
                  ),
                )),
            Text(
              _item.name,
              style: TextStyle(fontSize: 23),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\n₹${_item.price.floor()} ',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  TextSpan(
                    text: '₹${_item.cost.floor()}',
                    style: TextStyle(
                        fontSize: 23,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[700]),
                  ),
                  TextSpan(
                    text:
                        '  ${(((_item.cost - _item.price) / _item.cost) * 100).ceil()}% OFF!',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    color: Colors.grey[200],
                    onPressed: () {
                      cartItems.add(_item);
                      Navigator.pushNamed(context, 'cart');
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    color: Colors.green,
                    onPressed: () {},
                    child: Text(
                      'Buy ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(8),
                color: Colors.grey[200],
                // width: double.infinity,
                onPressed: () async {
                  if (_item.adurl == '') return;
                  if (await canLaunch(_item.adurl)) {
                    await launch(_item.adurl);
                  } else {
                    throw 'Could not launch ${_item.adurl}';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('View Product Ad'),
                    Icon(Icons.launch),
                  ],
                ),
              ),
            ),
            _item.getrating() == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          'Customer Ratings',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text('No ratings till Now...')
                      ])
                : Container(
                    // height: 250,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Customer Ratings',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: getcolor(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white),
                                  Text(
                                    '${_item.getrating().toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'from ${_item.gettotal().floor()} ratings',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            )
                          ],
                        ),
                        Expanded(
                          child: PieChart(PieChartData(
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 30,
                              sections: [
                                PieChartSectionData(
                                    color: Colors.red,
                                    title: ' ',
                                    value: _item.rating[1]),
                                PieChartSectionData(
                                    color: Colors.orange,
                                    title: ' ',
                                    value: _item.rating[2]),
                                PieChartSectionData(
                                    color: Colors.yellow,
                                    title: ' ',
                                    value: _item.rating[3]),
                                PieChartSectionData(
                                    color: Colors.lightGreen,
                                    title: ' ',
                                    value: _item.rating[4]),
                                PieChartSectionData(
                                    color: Colors.green,
                                    title: ' ',
                                    value: _item.rating[5]),
                              ])),
                        )
                      ],
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  'Specifications',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    for (String s in _item.specs.keys)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          for (String sr in _item.specs[s].keys)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      sr,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _item.specs[s][sr],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Divider(
                            thickness: 1,
                          )
                        ],
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
