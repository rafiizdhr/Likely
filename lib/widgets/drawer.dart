part of 'widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Provider.of<ThemeModeData>(context).isDarkModeActive;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      width: Get.width * 0.5,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Setting",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white),
            trailing: Switch(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.black,
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
