part of 'providers.dart';

class DateProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  int _age = 0;

  DateTime get selectedDate => _selectedDate;
  int get age => _age;

  set selectedDate(DateTime date) {
    _selectedDate = date;
    _calculateAge();
    notifyListeners();
  }

  void _calculateAge() {
    DateTime currentDate = DateTime.now();
    _age = currentDate.year - _selectedDate.year;
    if (currentDate.month < _selectedDate.month ||
        (currentDate.month == _selectedDate.month &&
            currentDate.day < _selectedDate.day)) {
      _age--;
    }
  }
}
