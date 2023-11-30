part of 'pages.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
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
                  SizedBox(height: 10),
                  // Tombol "Sign In"
                  ElevatedButton(
                    onPressed: () {
                      String email = emailController.text;
                      String password = passwordController.text;

                      Navigator.pushReplacementNamed(context, '/navbar');
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(300, 45)),
                    ),
                    child: Text('Sign In'),
                  ),
                  SizedBox(height: 10),
                  // Pilihan untuk mendaftar (signup)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text('Belum memiliki akun? Sign Up'),
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
