part of 'pages.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              Container(
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
                                    shape: BoxShape.circle,
                                    color: Color(0xffD6D6D6)),
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                          'Name', Icons.person_outlined, nameController,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Name is required!';
                        }

                        if (input.length < 5) {
                          return 'Please enter a valid name!';
                        }
                        return null;
                      }, onTap: () async {}, readOnly: false),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          'Age', Icons.nine_mp_outlined, homeController,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Age is required!';
                        }
                        return null;
                      }, onTap: () async {}, readOnly: false),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          'Location', Icons.location_city, businessController,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Location is required!';
                        }
                      }, onTap: () async {}, readOnly: false),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget('Gender', Icons.people, shopController,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Gender required!';
                        }
                        return null;
                      }, onTap: () async {}, readOnly: false),
                      const SizedBox(
                        height: 250,
                      ),
                    ],
                  ),
                ),
              )
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

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: CupertinoColors.activeGreen,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
