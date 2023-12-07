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
        seedColor: const Color(0xFF7512B2),
        brightness: dark ? Brightness.dark : Brightness.light,
        primary: dark
            ? const Color(0xFF35155D)
            : const Color.fromARGB(255, 224, 93, 248),
        onPrimary: dark
            ? const Color.fromARGB(255, 105, 29, 198)
            : const Color.fromARGB(255, 146, 60, 199),
        secondary: dark ? const Color.fromARGB(255, 28, 11, 48) : Colors.white,
        tertiary: dark ? Colors.white : const Color.fromARGB(255, 28, 11, 48),
      ),
    );
  }
}
