import 'package:flutter/material.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/Screens/itemDetails.dart';

class CartItem extends StatefulWidget {
  final Item _item;
  CartItem(this._item);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Item _item;
  int _quantity = 1;
  @override
  void initState() {
    super.initState();
    _item = widget._item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 240,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ItemDetail(_item);
            },
          ));
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.network(
                      _item.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _item.name,
                          style: TextStyle(fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('Rs. ${_item.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 20)),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Qty: ',
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                child: RaisedButton(
                                  color: _quantity > 1
                                      ? Colors.grey[300]
                                      : Colors.grey[100],
                                  elevation: _quantity > 1 ? 5 : 1,
                                  child:
                                      Text('-', style: TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    setState(() {
                                      if (_quantity > 1) _quantity--;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    _quantity.toString(),
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              Expanded(
                                child: RaisedButton(
                                  elevation: 5,
                                  child:
                                      Text('+', style: TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.green,
                                onPressed: () {},
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(color: Colors.white),
                                )),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.grey[300],
                              child: Text('Remove'),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
