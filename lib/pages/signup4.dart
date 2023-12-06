part of 'pages.dart';

class SignUp4 extends StatefulWidget {
  String nama;
  String password;
  String email;
  String tgl_lahir;
  int umur;
  String gender;

  SignUp4({
    super.key,
    required this.nama,
    required this.email,
    required this.umur,
    required this.tgl_lahir,
    required this.password,
    required this.gender,
  });

  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  final _auth = Auth();
  final ImagePicker _picker = ImagePicker();

  File? image; 

  getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void handleSignup() async {
    print('tes');
    try {
      await _auth.regis(
        nama: widget.nama,
        email: widget.email,
        password: widget.password,
        gender: widget.gender,
        tgl_lahir: widget.tgl_lahir,
        umur: widget.umur,
        foto: image!
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Sign Up Successful'),
        ),
      );
      Duration(seconds: 2);
      Navigator.popAndPushNamed(context, '/Home');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Background(
        lebar: lebar,
        tinggi: tinggi,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: image == null
                      ? Container(
                          width: 200,
                          height: 200,
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
                          width: 200,
                          height: 200,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(image!),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: Color(0xffD6D6D6)),
                        ),
                ),
                ElevatedButton(
                  onPressed: handleSignup,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(300, 45)),
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Text(
                    'Create Your Account',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
