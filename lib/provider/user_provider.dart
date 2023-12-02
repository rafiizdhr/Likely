part of 'providers.dart';

class DataUserProvider extends ChangeNotifier {
  late List<DataUser> _otherUsers = [];

  List<DataUser> get otherUsers => _otherUsers;

  Future<void> fetchOtherUsersChats(String currentUserId) async {
    _otherUsers = await getUsersFromChats(currentUserId);
    notifyListeners();
  }

  Future<List<DataUser>> getUsersFromChats(String currentUserId) async {
    List<DataUser> users = [];
    try {
      QuerySnapshot<Map<String, dynamic>> chatsSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('anggota', arrayContains: currentUserId)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> chatDoc in chatsSnapshot.docs) {
        List<dynamic> members = chatDoc['anggota'];
        String otherUserId = members.firstWhere((member) => member != currentUserId);
        DataUser? user = await getDataUser(otherUserId);
        users.add(user!);
      }
    } catch (error) {
      print("Error fetching users from chats: $error");
    }
    return users;
  }

  Future<DataUser?> getDataUser(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      return DataUser.fromMap(userDoc.data() ?? {});
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }
}