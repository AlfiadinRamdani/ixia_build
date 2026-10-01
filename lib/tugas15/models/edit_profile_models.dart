// To parse this JSON data, do
//
//     final editProfileRequest = editProfileRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'edit_profile_models.g.dart';

EditProfileRequest editProfileRequestFromJson(String str) =>
    EditProfileRequest.fromJson(json.decode(str));

String editProfileRequestToJson(EditProfileRequest data) =>
    json.encode(data.toJson());

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;

  EditProfileRequest({this.name, this.email});

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}
