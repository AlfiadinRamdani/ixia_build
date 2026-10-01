import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'history_models.g.dart';

HistoryModels historyModelsFromJson(String str) =>
    HistoryModels.fromJson(json.decode(str));

String historyModelsToJson(HistoryModels data) => json.encode(data.toJson());

@JsonSerializable()
class HistoryModels {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<HistoryData>? data;

  HistoryModels({this.message, this.data});

  factory HistoryModels.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelsFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelsToJson(this);
}

@JsonSerializable()
class HistoryData {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "check_in")
  final DateTime? checkIn;
  @JsonKey(name: "check_in_location")
  final String? checkInLocation;
  @JsonKey(name: "check_in_address")
  final String? checkInAddress;
  @JsonKey(name: "check_out")
  final DateTime? checkOut;
  @JsonKey(name: "check_out_location")
  final String? checkOutLocation;
  @JsonKey(name: "check_out_address")
  final String? checkOutAddress;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "alasan_izin")
  final dynamic alasanIzin;
  @JsonKey(name: "check_in_lat")
  final dynamic checkInLat;
  @JsonKey(name: "check_in_lng")
  final dynamic checkInLng;
  @JsonKey(name: "check_out_lat")
  final dynamic checkOutLat;
  @JsonKey(name: "check_out_lng")
  final dynamic checkOutLng;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  HistoryData({
    this.id,
    this.userId,
    this.checkIn,
    this.checkInLocation,
    this.checkInAddress,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutAddress,
    this.status,
    this.alasanIzin,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDataToJson(this);
}

/// Model untuk request edit profile
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

