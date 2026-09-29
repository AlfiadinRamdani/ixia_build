// To parse this JSON data, do
//
//     final checkOutModels = checkOutModelsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'check_out_models.g.dart';

CheckOutModels checkOutModelsFromJson(String str) => CheckOutModels.fromJson(json.decode(str));

String checkOutModelsToJson(CheckOutModels data) => json.encode(data.toJson());

@JsonSerializable()
class CheckOutModels {
    @JsonKey(name: "check_out_lat")
    final String? checkOutLat;
    @JsonKey(name: "check_out_lng")
    final String? checkOutLng;
    @JsonKey(name: "check_out_location")
    final String? checkOutLocation;
    @JsonKey(name: "check_out_address")
    final String? checkOutAddress;

    CheckOutModels({
        this.checkOutLat,
        this.checkOutLng,
        this.checkOutLocation,
        this.checkOutAddress,
    });

    factory CheckOutModels.fromJson(Map<String, dynamic> json) => _$CheckOutModelsFromJson(json);

    Map<String, dynamic> toJson() => _$CheckOutModelsToJson(this);
}
// To parse this JSON data, do
//
//     final checkOut = checkOutFromJson(jsonString);


CheckOut checkOutFromJson(String str) => CheckOut.fromJson(json.decode(str));

String checkOutToJson(CheckOut data) => json.encode(data.toJson());

@JsonSerializable()
class CheckOut {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "data")
    final Data? data;

    CheckOut({
        this.message,
        this.data,
    });

    factory CheckOut.fromJson(Map<String, dynamic> json) => _$CheckOutFromJson(json);

    Map<String, dynamic> toJson() => _$CheckOutToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "user_id")
    final int? userId;
    @JsonKey(name: "check_in")
    final String? checkIn;
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
    @JsonKey(name: "created_at")
    final DateTime? createdAt;
    @JsonKey(name: "updated_at")
    final DateTime? updatedAt;
    @JsonKey(name: "check_in_lat")
    final double? checkInLat;
    @JsonKey(name: "check_in_lng")
    final double? checkInLng;
    @JsonKey(name: "check_out_lat")
    final double? checkOutLat;
    @JsonKey(name: "check_out_lng")
    final double? checkOutLng;

    Data({
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
        this.createdAt,
        this.updatedAt,
        this.checkInLat,
        this.checkInLng,
        this.checkOutLat,
        this.checkOutLng,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

