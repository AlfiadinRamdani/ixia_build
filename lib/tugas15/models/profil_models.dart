// To parse this JSON data, do
//
//     final profilModels = profilModelsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profil_models.g.dart';

ProfilModels profilModelsFromJson(String str) => ProfilModels.fromJson(json.decode(str));

String profilModelsToJson(ProfilModels data) => json.encode(data.toJson());

@JsonSerializable()
class ProfilModels {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "data")
    final Data? data;

    ProfilModels({
        this.message,
        this.data,
    });

    factory ProfilModels.fromJson(Map<String, dynamic> json) => _$ProfilModelsFromJson(json);

    Map<String, dynamic> toJson() => _$ProfilModelsToJson(this);
}

@JsonSerializable()
class Data {
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

    Data({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
