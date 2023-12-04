part of 'pages.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditImageProfile(),
              SizedBox(height: 10),
              AccountSettings(),
              SizedBox(height: 25),
              DiscoverySettings(),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  TextFieldWidget(String title, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: () => onTap!(),
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(iconData, color: CupertinoColors.systemPurple),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget EditImageProfile() => Container(
        height: Get.height * 0.33,
        child: Stack(
          children: [
            ProfileWidget(),
            Align(
              alignment: AlignmentDirectional.center,
              child: InkWell(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: selectedImage == null
                    ? Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                            color: Color(0xffD6D6D6)),
                      ),
              ),
            ),
          ],
        ),
      );

  Widget AccountSettings() => Container(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Account Settings",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/ProfileEdit"),
                  child: Text("Edit",
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 8, 111, 196),
                          fontSize: 17)),
                ),
              ],
            ),
            SizedBox(height: 12),
            kontener("Name", "Udin Syamsudin"),
            SizedBox(height: 12),
            kontener("Phone Number", "+62 81220902112"),
            SizedBox(height: 12),
            kontener("Date of Birth", "01-01-1999"),
            SizedBox(height: 12),
            kontener("Email", "udinsyam@gmail.com"),
          ],
        ),
      );

  Widget DiscoverySettings() => Container(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discovery Settings",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.black38),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show Me",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Women",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 8, 111, 196)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.black38),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Age Range",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "22 - 34",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Container kontener(String kiri, String kanan) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: Colors.black38),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kiri,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              kanan,
              style: TextStyle(color: Color.fromARGB(255, 54, 51, 51)),
            ),
          ],
        ),
      ),
    );
  }
}
