import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Swiper(
          itemBuilder: (BuildContext context, int index) => SwiperCard();
            return Card(child: Container(color: Theme.of(context).accentColor));
          },
          itemCount: 10,
          itemWidth: 300.0,
          itemHeight: 400.0,
          layout: SwiperLayout.TINDER,
        ),
      ),
    );
  }
}
