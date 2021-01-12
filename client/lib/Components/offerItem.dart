import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/values.dart';

class OfferItem extends StatelessWidget {
  final Item item;
  OfferItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: colors[3],
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${item.offer.ceil()}% Off',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            '₹${((100 / (100 - item.offer)) * item.price).ceil()} ',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[700],
                            fontSize: 23),
                      ),
                      TextSpan(
                        text: '  ₹${item.price.floor()}  ',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ])),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      color: colors[1],
                    )
                  ])),
              Expanded(child: Image.network(item.image)),
            ],
          )),
    );
  }
}