part of 'pages.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Background(
        tinggi: MediaQuery.of(context).size.height,
        lebar: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        TextFieldWidget('Date of Birth', Icons.nine_mp_outlined,
                            homeController, (String? input) {
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
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
}
