import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  TextEditingController namaController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final _controller = PageController();

// Variabel untuk mengontrol visibilitas FAB

  @override
  void initState() {
    super.initState();

    // Listen to the page controller and update _showFAB accordingly
    _controller.addListener(() {
      if (_controller.page == 2) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 250, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/image/onboarding1.png",
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          // Tidak ada fit, sehingga gambar akan full size
                        ),
                      ),
                      Stack(children: [
                        Center(
                          child: Image.asset(
                            "assets/image/onboarding2.png",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            // Tidak ada fit, sehingga gambar akan full size
                          ),
                        ),
                        Positioned(
                          left: 110,
                          top: 700,
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Signup');
                                // Tambahkan aksi yang ingin dijalankan saat tombol ditekan
                              },
                              child: Container(
                                width: 120,
                                child: Text(
                                  "Get Started",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ]),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      axisDirection: Axis.horizontal,
                      effect: const WormEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          dotWidth: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
