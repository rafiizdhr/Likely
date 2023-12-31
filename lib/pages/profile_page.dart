part of 'pages.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<DataUser?>? currentUser;

  void initState() {
    super.initState();
    fetchuser().whenComplete(
      () => changedategender(),
    );
  }

  Future<void> fetchuser() async {
    await Provider.of<DataUserProvider>(context, listen: false)
        .fetchCurrentUser(FirebaseAuth.instance.currentUser!.uid);
  }

  void changedategender() {
    DateFormat format = DateFormat("dd-MM-yyyy");
    Provider.of<DateProvider>(context, listen: false).selectedDate =
        format.parse(Provider.of<DataUserProvider>(context, listen: false)
            .currentUsers
            .tgl_lahir!);
    Provider.of<GenderProvider>(context, listen: false).setGender(
        Provider.of<DataUserProvider>(context, listen: false)
            .currentUsers
            .jenis_kelamin!);
  }

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
      body: Background(
        tinggi: MediaQuery.of(context).size.height,
        lebar: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditImageProfile(),
                const SizedBox(height: 30),
                AccountSettings(),
                const SizedBox(height: 25),
                DiscoverySettings(),
                const SizedBox(height: 60),
              ],
            ),
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
              color: const Color(0xffA7A7A7)),
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
                color: const Color(0xffA7A7A7)),
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
        height: Get.height * 0.3,
        child: Stack(
          children: [
            Consumer<DataUserProvider>(
                builder: (ctx, user, _) => ProfileWidget(context,
                    subtitle:
                        '${user.currentUsers.nama!}, ${user.currentUsers.umur!.toString()}')),
            Align(
              alignment: AlignmentDirectional.center,
              child: InkWell(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: selectedImage == null
                    ? Consumer<DataUserProvider>(
                        builder: (context, userProvider, _) => Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      userProvider.currentUsers.foto!),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: const Color(0xffD6D6D6)),
                        ),
                      )
                    : Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: const Color(0xffD6D6D6)),
                      ),
              ),
            ),
          ],
        ),
      );

  Widget AccountSettings() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Consumer<DataUserProvider>(
          builder: (context, userProvider, _) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Account Settings",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/ProfileEdit");
                    },
                    child: Text("Edit",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 8, 111, 196),
                            fontSize: 17)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              kontener("Name", userProvider.currentUsers.nama!),
              const SizedBox(height: 12),
              kontener("Date of Birth", userProvider.currentUsers.tgl_lahir!),
              const SizedBox(height: 12),
              kontener("Umur", userProvider.currentUsers.umur!.toString()),
            ],
          ),
        ),
      );

  Widget DiscoverySettings() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discovery Settings",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Show Me",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Consumer<DataUserProvider>(
                      builder: (ctx, user, _) => Text(
                        user.currentUsers.jenis_kelamin == 'Male'
                            ? "Women"
                            : "Men",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Age Range",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        Consumer<DataUserProvider>(
                          builder: (ctx, user, _) => Text(
                            "${user.currentUsers.umur} - ${user.currentUsers.umur! + 10}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kiri,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.white),
            ),
            Text(
              kanan,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
