part of 'pages.dart';

// Make sure to add these imports

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: lebar,
            height: tinggi,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Input email
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: namaController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Input password
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Input konfirmasi password
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol "Sign Up"
                  ElevatedButton(
                    onPressed: () {
                      if (!_isValidEmail(emailController.text)) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Invalid email format'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp2(
                              nama: namaController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ),
                        );
                      } else {
                        // Menampilkan pesan jika password tidak cocok
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Password tidak cocok'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(300, 45)),
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
                  const SizedBox(height: 10),
                  // Pilihan untuk mendaftar (signup)
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/Signin');
                    },
                    child: const Text(
                      'Telah memiliki akun? Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Simple email validation using regex
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}
