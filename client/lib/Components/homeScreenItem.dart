import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/values.dart';

class HomeScreenItem extends StatelessWidget {
  final Item item;
  HomeScreenItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffc5c5c5),
      child: Container(
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(flex: 65, child: Image.network(item.image)),
              Expanded(
                  flex: 20,
                  child: Center(
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15, color: Colors.white.withOpacity(0.9)),
                    ),
                  )),
              Expanded(
                  flex: 15,
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹${item.price.floor()}  ',
                        style: TextStyle(
                            fontSize: 25, color: Colors.white.withOpacity(0.9)),
                      ),
                      TextSpan(
                        text:
                            '₹${((100 / (100 - item.offer)) * item.price).ceil()}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[500]),
                      ),
                      TextSpan(
                        text: '  ${item.offer.floor()} % Off',
                        // textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ))),
            ],
          )),
    );
  }
}
