import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int? id;
  final String nama;
  final String email;
  final String noHp;
  final String password;
  final String asalKota;
  UserModel({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.password,
    required this.asalKota,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'email': email,
      'noHp': noHp,
      'password': password,
      'asalKota': asalKota,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      email: map['email'] as String,
      noHp: map['noHp'] as String,
      password: map['password'] as String,
      asalKota: map['asalKota'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
