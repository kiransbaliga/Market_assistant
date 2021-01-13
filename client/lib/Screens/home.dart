import 'package:flutter/material.dart';

//packages
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

//other files
import 'package:markus/Components/homeScreenItem.dart';
import 'package:markus/Components/offerItem.dart';
import 'package:markus/Components/sliverAppBar.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/to_Database/dbMethods.dart';
import 'package:markus/values.dart';

class HomePage extends StatelessWidget {
  final List<Item> _offers = [
    Item(
        name: 'Pacific Organic Chicken and Mutton Soup',
        price: 400,
        offer: 10,
        image:
            'https://www.pacificfoods.com/wp-content/uploads/2019/03/Organic-Chicken-Wild-Rice-Soup-17.6oz-1.png'),
    Item(
        name: 'Double Horse Rice Sevai 2 Kg',
        price: 299,
        offer: 10,
        image:
            'https://www.pacificfoods.com/wp-content/uploads/2019/03/Organic-Chicken-Wild-Rice-Soup-17.6oz-1.png'),
    Item(
        name: 'Delhi Basmathi Rice 5 Kg',
        price: 20,
        offer: 30,
        image:
            'https://www.sbl1972.com/images/products/edited/delhi-dubar-rice.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png')
  ];

  final List<Item> _recommends = [
    Item(
        name: 'Snickers Pack of 20',
        price: 400,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Double Horse Rice Sevai 2 Kg',
        price: 299,
        offer: 10,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Delhi Basmathi Rice 5 Kg',
        price: 20,
        offer: 30,
        image:
            'https://www.sbl1972.com/images/products/edited/delhi-dubar-rice.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png'),
    Item(
        name: 'Snickers',
        price: 20,
        offer: 30,
        image:
            'https://paradisealacarte.com/wp-content/uploads/2016/10/0350.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff30442e),
      body: CustomScrollView(
        slivers: [
          MySliverAppBar(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                    height: 200,
                    child: Swiper(
                      itemCount: _offers.length,
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      autoplayDelay: 3000,
                      itemBuilder: (BuildContext context, int index) {
                        return OfferItem(_offers[index]);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended for you...',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black //Colors.white.withOpacity(0.9)
                            ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                              color: Colors.black //white.withOpacity(0.9)
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(_recommends[index]);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most popular...',
                        style: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.9)),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text('See All',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)))),
                    ],
                  ),
                ),
                Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(_recommends[index]);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Based on your recent activity...',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text('See All',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)))),
                    ],
                  ),
                ),
                Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(_recommends[index]);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest on market...',
                        style: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.9)),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text('See All',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)))),
                    ],
                  ),
                ),
                Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(_recommends[index]);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discover something new...',
                        style: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.9)),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text('See All',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)))),
                    ],
                  ),
                ),
                Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(_recommends[index]);
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
