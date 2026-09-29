// To parse this JSON data, do
//
//     final loginmodels = loginmodelsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_models.g.dart';

Loginmodels loginmodelsFromJson(String str) =>
    Loginmodels.fromJson(json.decode(str));

String loginmodelsToJson(Loginmodels data) => json.encode(data.toJson());

@JsonSerializable()
class Loginmodels {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  Loginmodels({this.email, this.password});

  factory Loginmodels.fromJson(Map<String, dynamic> json) =>
      _$LoginmodelsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginmodelsToJson(this);
}
// To parse this JSON data, do
//
//     final loginrespon = loginresponFromJson(jsonString);

@JsonSerializable()
class Loginrespon {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final Data? data;

  Loginrespon({this.message, this.data});

  factory Loginrespon.fromJson(Map<String, dynamic> json) =>
      _$LoginresponFromJson(json);

  Map<String, dynamic> toJson() => _$LoginresponToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final User? user;

  Data({this.token, this.user});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "email_verified_at")
  final dynamic emailVerifiedAt;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
