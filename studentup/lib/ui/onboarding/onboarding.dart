import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
//import 'package:studentup/router.dart';
//import 'package:studentup/util/env.dart';

class Onboarding extends StatelessWidget {
  final pages = [
    Container(
      width: double.infinity,
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Hi",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "It's Me",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Sahdeep",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Take a",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "look at",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Liquid Swipe",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Liked?",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Fork!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Give Star!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.yellowAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Can be",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Used for",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Onboarding Design",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Do",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Try",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "It, Thank You",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: LiquidSwipe(key: key, pages: pages),
    );
  }
}
