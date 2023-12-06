part of 'providers.dart';

class GenderProvider extends ChangeNotifier {
  String _selectedGender = '';

  String get selectedGender => _selectedGender;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
  
  void reset() {
    _selectedGender = '';
    notifyListeners();
  }
}
