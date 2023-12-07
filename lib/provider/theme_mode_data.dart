part of 'providers.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
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
        primary: dark ? Color(0xFF35155D) : Color.fromARGB(255, 224, 93, 248),
        onPrimary: dark ? Color.fromARGB(255, 105, 29, 198) : Color.fromARGB(255, 146, 60, 199),
        secondary: dark ? Color.fromARGB(255, 28, 11, 48) : Colors.white,
        tertiary: dark ? Colors.white : Color.fromARGB(255, 28, 11, 48),
      ),
    );
  }
}
