import 'package:flutter/material.dart';
import 'package:markus/Components/cartItem.dart';
import 'package:markus/Objects/itemclass.dart';

List<Item> cartItems = [
  Item(
      name: 'Appy Fizz 600ml Bottle',
      image:
          'https://www.morningbag.com/api/public/product/2286/1604372183870-400x400.png',
      price: 35,
      cost: 36)
];

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                for (Item it in cartItems)
                  CartItem(it, () {
                    setState(() {
                      cartItems.remove(it);
                    });
                  }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 280,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Proceed to Checkout ', style: TextStyle(fontSize: 17)),
              Icon(Icons.arrow_forward)
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
