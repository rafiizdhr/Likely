import 'package:Likely/chat_page.dart';
import 'package:Likely/home_screen.dart';
import 'package:Likely/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PageData extends ChangeNotifier {
  int idxPage = 0;

  List<Screen> pages = [
    Screen(page: HomeScreen()),
    Screen(page: ChatPage()),
    Screen(page: ProfilePage()),
  ];

  void changeIndex(int index) {
    idxPage = index;
    notifyListeners();
  }

  Widget display() {
    return pages[idxPage].show_page();
  }
}

class Screen {
  Widget page;

  Screen({required this.page});

  Widget show_page() {
    return page;
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Provider.of<PageData>(context).display(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.5,
              blurRadius: 40,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: BottomNavigationBar(
            fixedColor: Colors.deepPurple,
            backgroundColor: Colors.white,
            onTap: (value) {
              Provider.of<PageData>(context, listen: false).changeIndex(value);
            },
            currentIndex: Provider.of<PageData>(context, listen: false).idxPage,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
