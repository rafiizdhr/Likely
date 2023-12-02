part of 'pages.dart';

// Make sure to add these imports

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Input email
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          color: Theme.of(context).iconTheme.color,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Input password
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          color: Theme.of(context).iconTheme.color,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Input konfirmasi password
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          color: Theme.of(context).iconTheme.color,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Tombol "Sign Up"
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      // Email format validation
                      if (!_isValidEmail(email)) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Invalid email format'),
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
                        return;
                      }

                      // Validasi password
                      if (password == confirmPassword) {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Signup Successful'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email: $email'),
                                    Text('Password: $password'),
                                  ],
                                ),
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
                        } catch (e) {
                          // Handle specific Firebase authentication errors
                          String errorMessage = 'Email/Password salah!';

                          if (e is FirebaseAuthException) {
                            switch (e.code) {
                              case 'weak-password':
                                errorMessage = 'The password is too weak';
                                break;
                              case 'email-already-in-use':
                                errorMessage =
                                    'The account already exists for that email';
                                break;
                              // Add more cases as needed
                            }
                          }

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(errorMessage),
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
                      } else {
                        // Menampilkan pesan jika password tidak cocok
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Password tidak cocok'),
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
                    ),
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 10),
                  // Pilihan untuk mendaftar (signup)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    child: Text('Telah memiliki akun? Sign In'),
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
