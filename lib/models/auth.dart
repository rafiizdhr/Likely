part of 'models.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> regis({
    required String nama,
    required String email,
    required String password,
    required String tgl_lahir,
    required String gender,
    required File foto,
    required int umur,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = _auth.currentUser;
      print(user!.uid);

      var url_foto = '';
      try {
        var poto = foto;
        var snapshot =
            await _storage.ref().child('user_images/${user.uid}').putFile(poto);

        url_foto = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print(e);
        return;
      }

      await _firestore.collection('users').doc(user.uid).set(
        {
          'id': user.uid,
          'nama': nama,
          'umur': umur,
          'tgl_lahir': tgl_lahir,
          'jenis_kelamin': gender,
          'foto': url_foto,
        },
      );
    } catch (e) {
      print('Registration failed: $e');
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
