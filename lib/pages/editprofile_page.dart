part of 'pages.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? currentId;

  void initState() {
    DataUser user =
        Provider.of<DataUserProvider>(context, listen: false).currentUsers;
    nameController.text = user.nama!;
    currentId = user.id;

    DateTime birth =
        Provider.of<DateProvider>(context, listen: false).selectedDate;

    birthController.text = '${birth.day}-${birth.month}-${birth.year}';
    nameController.text = user.nama!;
    super.initState();
  }

  void handleUpdate() {
    Provider.of<DataUserProvider>(context, listen: false).updateDataUser(
      userId: currentId!,
      nama: nameController.text,
      tgl_lahir: birthController.text,
      gender:
          Provider.of<GenderProvider>(context, listen: false).selectedGender,
      umur: Provider.of<DateProvider>(context, listen: false).age,
    );

    Provider.of<GenderProvider>(context, listen: false).reset();
    Provider.of<DateProvider>(context, listen: false).reset();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Update Successful'),
      ),
    );

    Navigator.popAndPushNamed(context, '/Home');
  }

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
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            birthController, (String? input) {
                          if (input!.isEmpty) {
                            return 'Age is required!';
                          }
                          return null;
                        }, onTap: () async {}, readOnly: true),
                        const SizedBox(
                          height: 30,
                        ),
                        const Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            SelectableBox(
                              lebar: 170,
                              tinggi: 80,
                              label: 'Male',
                              icon: Icons.male,
                              gender: 'Male',
                            ),
                            SelectableBox(
                              lebar: 170,
                              tinggi: 80,
                              label: 'Female',
                              icon: Icons.female,
                              gender: 'Female',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: handleUpdate,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(300, 45)),
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDate =
        context.read<DateProvider>().selectedDate ?? currentDate;

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (picked != null) {
      context.read<DateProvider>().selectedDate = picked;
      birthController.text = '${picked.day}-${picked.month}-${picked.year}';
    }
  }

  TextFieldWidget(String title, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1)
                ],
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                readOnly: readOnly,
                onTap: () => onTap!(),
                validator: (input) => validator(input),
                controller: controller,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    iconData,
                    color: CupertinoColors.systemPurple,
                  ),
                  suffixIcon: title == 'Date of Birth'
                      ? IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _selectDate(context),
                        )
                      : null,
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
