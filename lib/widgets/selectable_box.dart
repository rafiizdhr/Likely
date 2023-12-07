part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final String label;
  final IconData icon;
  final String gender;
  final double lebar;
  final double tinggi;

  const SelectableBox({
    required this.label,
    required this.icon,
    required this.gender,
    required this.lebar,
    required this.tinggi,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<GenderProvider>(context, listen: false).setGender(gender);
      },
      child: Consumer<GenderProvider>(
        builder: (context, genderProvider, child) {
          bool isSelected = genderProvider.selectedGender == gender;

          return Container(
            width: lebar,
            height: tinggi,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color:  isSelected ? Colors.white : Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                color: isSelected ? Theme.of(context).colorScheme.onPrimary : Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: isSelected ? Theme.of(context).colorScheme.onPrimary : Colors.white
                ),
                SizedBox(height: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).colorScheme.onPrimary : Colors.white
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
