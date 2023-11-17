import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget greenIntroWidget() {
  return Container(
    width: Get.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/mask.png'), fit: BoxFit.cover)),
    height: Get.height * 0.6,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ),
  );
}

Widget ProfileWidget({String title = "", String subtitle = "Udin, 22"}) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage('assets/image/mask.png'),
            fit: BoxFit.fill)),
    height: Get.height * 2,
    child: Container(
        height: Get.height * 0.5,
        width: Get.width,
        margin: EdgeInsets.only(bottom: Get.height * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 140),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        )),
  );
}
