part of 'widgets.dart';

Widget ProfileWidget(BuildContext context, {String subtitle = "Nama, Umur"}) {
  return Container(
    width: Get.width,
    height: Get.height * 2,
    child: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.only(bottom: Get.height * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 130),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        )),
  );
}
