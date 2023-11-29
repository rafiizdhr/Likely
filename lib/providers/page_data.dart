part of 'providers.dart';

class PageData with ChangeNotifier {
  int _idxPage = 0;

  int get idxPage => _idxPage;

  void changeIndex(int value) {
    _idxPage = value;
    notifyListeners();
  }

  Widget display() {
    switch (_idxPage) {
      case 0:
        return HomeScreen(); // Replace with your HomeScreen widget
      case 1:
        return ChatPage(); // Replace with your ChatScreen widget
      case 2:
        return ProfileSettingScreen(); // Replace with your ProfileScreen widget
      default:
        return Container(); // Default case, replace with appropriate widget
    }
  }
}