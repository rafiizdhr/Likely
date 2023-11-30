part of 'widgets.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkModeActive => _themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Provider.of<ThemeModeData>(context).isDarkModeActive;
    return Drawer(
      backgroundColor: Colors.purple,
      width: Get.width * 0.5,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Setting",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white),
            title: Text(
              isDark ? "Dark Mode" : "Light Mode",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (bool value) {
                Provider.of<ThemeModeData>(context, listen: false)
                    .changeTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
            onTap: () {
              Provider.of<ThemeModeData>(context, listen: false)
                  .changeTheme(isDark ? ThemeMode.dark : ThemeMode.light);
            },
          )
        ],
      ),
    );
  }
}
