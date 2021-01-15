import 'package:flutter/material.dart';

//packages
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

//other files
import 'package:markus/Components/homeScreenItem.dart';
import 'package:markus/Components/offerItem.dart';
import 'package:markus/Components/sliverAppBar.dart';
import 'package:markus/Objects/itemclass.dart';
import 'package:markus/items.dart';
import 'package:markus/to_Database/dbMethods.dart';
import 'package:markus/values.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff248f24),
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
                    color: Color(0xff1c1c1c),
                    height: 200,
                    child: Swiper(
                      itemCount: offers.length,
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      autoplayDelay: 3000,
                      itemBuilder: (BuildContext context, int index) {
                        return OfferItem(items[offers[index]]);
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
                            color: Colors.white.withOpacity(0.99)),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    color: Color(0xff1c1c1c),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommends.length,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(items[recommends[index]]);
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
                    color: Color(0xff1c1c1c),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popular.length,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(items[popular[index]]);
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
                    color: Color(0xff1c1c1c),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recent.length,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(items[recent[index]]);
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
                    color: Color(0xff1c1c1c),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: latest.length,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(items[latest[index]]);
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
                    color: Color(0xff1c1c1c),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: discover.length,
                      itemBuilder: (context, index) {
                        return HomeScreenItem(items[discover[index]]);
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
