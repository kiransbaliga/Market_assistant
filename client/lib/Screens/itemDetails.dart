import 'package:flutter/material.dart';
import 'package:markus/Objects/itemclass.dart';

class ItemDetail extends StatelessWidget {
  final Item _item;
  ItemDetail(this._item);
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.width / 1.5,
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
                    text: '\n ₹${_item.price.floor()} ',
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
                        '    ${(((_item.cost - _item.price) / _item.cost) * 100).ceil()}% OFF!',
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
                FlatButton(
                  color: Colors.green,
                  onPressed: () {},
                  child: Text('Buy Now'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Add to Cart'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.green,
              minWidth: double.infinity,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Official Site of the Brand'),
                  Icon(Icons.launch),
                ],
              ),
            ),
            Row(
              children: [
                Text('Customer Ratings'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
