import 'package:Likely/bottom_navbar.dart';
import 'package:Likely/signin.dart';
import 'package:Likely/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => PageData(),
        )
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            // home: HomeScreen(),
            debugShowCheckedModeBanner: false,
            routes: {
              "/navbar": (ctx) => BottomNavBar(),
              "/Signup": (ctx) => Signup(),
              "/Signin": (ctx) => Signin(),
            },
            initialRoute: "/Signin",
          );
        },
      ),
    );
  }
}