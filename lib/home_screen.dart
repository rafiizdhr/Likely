import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF7512B2),
        appBar: AppBar(
          toolbarHeight: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu, size: 25),
              ),
            ),
          ],
          title: Text(
            "Likely",
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Container(
          height: tinggi,
          width: lebar,
          child: Example(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7512B2),
                Color(0xFFBD94D7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  List<Color> kolor = [Colors.blue, Colors.green, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    List<Container> woy = List.generate(
      10,
      (index) => Container(
        alignment: Alignment.center,
        child: Text(index.toString()),
        color: kolor[Random().nextInt(4)],
      ),
    );

    return AppinioSwiper(
      cardsCount: 10,
      onSwiping: (AppinioSwiperDirection direction) {
        print(direction.toString());
      },
      cardsBuilder: (BuildContext context, int index) {
        return woy[index];
      },
      swipeOptions: AppinioSwipeOptions.symmetric(horizontal: true),
      onSwipe: (index, direction) {
        if (direction == AppinioSwiperDirection.right) {}
      },
      loop: true,
    );
  }
}

class Kartu extends StatelessWidget {
  Color warna;

  Kartu({super.key, required this.warna});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: warna,
    );
  }
}
