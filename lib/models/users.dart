part of 'models.dart';

class DataUser{
  String? id;
  String? nama;
  String? jenis_kelamin;
  int? umur;
  String? foto;

  DataUser({
    required this.id,
    required this.nama,
    required this.jenis_kelamin,
    required this.umur,
    required this.foto,
  });

  factory DataUser.fromMap(Map<String, dynamic> map) {
    return DataUser(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      jenis_kelamin: map['jenis_kelamin'] ?? '',
      umur: map['umur'] ?? 0,
      foto: map['foto'] ?? '',
    );
  }
}