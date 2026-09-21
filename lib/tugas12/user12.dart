class UserModel {
  int? id;
  String nama;
  String email;
  String noHp;
  String password;
  String asalKota;

  UserModel({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.password,
    required this.asalKota,
  });

  // Mengubah object UserModel menjadi Map
  // untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'no_hp': noHp,
      'password': password,
      'asal_kota': asalKota,
    };
  }

  // Mengubah data Map dari database
  // menjadi object UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      noHp: map['no_hp'],
      password: map['password'],
      asalKota: map['asal_kota'],
    );
  }
}