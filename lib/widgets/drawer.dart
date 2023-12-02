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
          SizedBox(height: 20),
          Text(
            "Setting",
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.tertiary),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.tertiary),
            title: Text(
              isDark ? "Dark Mode" : "Light Mode",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
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
