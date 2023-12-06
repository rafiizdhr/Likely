part of 'pages.dart';

class SignUp3 extends StatelessWidget {
  String nama;
  String password;
  String email;
  String tgl_lahir;
  int umur;

  SignUp3({
    super.key,
    required this.nama,
    required this.email,
    required this.umur,
    required this.tgl_lahir,
    required this.password,
  });

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
                Text(
                  'Select Your Gender',
                  style: GoogleFonts.poppins(color: Colors.white,
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectableBox(
                      label: 'Male',
                      icon: Icons.male,
                      gender: 'Male',
                    ),
                    SelectableBox(
                      label: 'Female',
                      icon: Icons.female,
                      gender: 'Female',
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<GenderProvider>(
                  builder: (context, genderProvider, _) => ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp4(
                              nama: nama,
                              email: email,
                              password: password,
                              umur: umur,
                              gender: genderProvider.selectedGender,
                              tgl_lahir: tgl_lahir,),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(300, 45)),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
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
