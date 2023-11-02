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
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF7512B2),
              Color(0xFFBD94D7),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
      ),
    );
  }
}
