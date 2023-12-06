part of 'pages.dart';

class SignUp2 extends StatelessWidget {
  String nama;
  String email;
  String password;

  SignUp2({
    super.key,
    required this.nama,
    required this.email,
    required this.password,
  });

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
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Background(
        lebar: lebar,
        tinggi: tinggi,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Your Birth Date',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Consumer<DateProvider>(
                            builder: (context, dateProvider, _) => Text(
                              '${dateProvider.selectedDate.day}-${dateProvider.selectedDate.month}-${dateProvider.selectedDate.year}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                Text(
                  'Your Age',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Consumer<DateProvider>(
                  builder: (context, dateProvider, _) =>
                      dateProvider.age != null
                          ? Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    dateProvider.age.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<DateProvider>(
                  builder: (context, dateProvider, _) => ElevatedButton(
                    onPressed: () {
                      if (dateProvider.age > 18) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp3(
                              nama: nama,
                              email: email,
                              password: password,
                              umur: dateProvider.age,
                              tgl_lahir:
                                  '${dateProvider.selectedDate.day}-${dateProvider.selectedDate.month}-${dateProvider.selectedDate.year}',
                            ),
                          ),
                        );
                      }else{
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('You are not old enough!'),
                              content: Text('Must be atleat 18 years old'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
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
