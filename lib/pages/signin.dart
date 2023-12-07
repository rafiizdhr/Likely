part of 'pages.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  Theme.of(context).colorScheme.onPrimary,
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
                    'Sign In',
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
                  const SizedBox(height: 20),
                  // Tombol "Sign In"
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;

                      try {
                        await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        Navigator.popAndPushNamed(context, "/Home");
                      } catch (e) {
                        // Handle specific Firebase authentication errors
                        String errorMessage = 'Email/Password salah!';

                        if (e is FirebaseAuthException) {
                          switch (e.code) {
                            case 'user-not-found':
                              errorMessage = 'No user found for that email';
                              break;
                            case 'wrong-password':
                              errorMessage =
                                  'Wrong password provided for that user';
                              break;
                            // Add more cases as needed
                          }
                        }

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(errorMessage),
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
                      'Sign In',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Pilihan untuk mendaftar (signup)
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        '/Signup',
                      );
                    },
                    child: const Text(
                      'Belum memiliki akun? Sign Up',
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
}
