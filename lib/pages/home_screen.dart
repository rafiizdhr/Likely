import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, size: 25),
            ),
          ),
        ],
        title: const Text(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Example(),
        ),
        decoration: const BoxDecoration(
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
    );
  }
}

class Example extends StatelessWidget {
  Example({super.key});
  List<Kartu> woy = List.generate(
    10,
    (index) => Kartu(
      warna: Colors.white,
      teks: index.toString(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppinioSwiper(
      cardsCount: 10,
      onSwiping: (AppinioSwiperDirection direction) {
        print(direction.toString());
      },
      cardsBuilder: (BuildContext context, int index) {
        return woy[index];
      },
      swipeOptions: const AppinioSwipeOptions.symmetric(horizontal: true),
      onSwipe: (index, direction) {
        if (direction == AppinioSwiperDirection.right) {}
      },
      loop: true,
    );
  }
}

class Kartu extends StatelessWidget {
  Color warna;
  String teks;

  Kartu({super.key, required this.warna, required this.teks});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: warna,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 30)
          ]),
      alignment: Alignment.center,
      child: Text(teks),
    );
  }
}
