import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/pages.dart';
import 'widgets/widgets.dart';
import 'provider/providers.dart';

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
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeModeData(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: ThemeData(),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: Provider.of<ThemeModeData>(context).themeMode,
            debugShowCheckedModeBanner: false,
            routes: {
              "/Home": (ctx) => BottomNavBar(),
              "/Signup": (ctx) => Signup(),
              "/Signin": (ctx) => Signin(),
              "/profile": (ctx) => ProfileSettingScreen(),
              "/chat": (ctx) => ChatField(),
            },
            initialRoute: "/Signin",
          );
        },
      ),
    );
  }
}
