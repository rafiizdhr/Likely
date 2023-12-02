part of 'providers.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkModeActive => _themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  ThemeData display(bool dark) {
    return ThemeData(
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF7512B2),
        brightness: dark ? Brightness.dark : Brightness.light,
        primary: dark ? Color(0xFF35155D) : Colors.purple[400],
        secondary: dark ? Colors.black : Colors.white,
        tertiary: dark ? Colors.white : Colors.black,
      ),
    );
  }
}
