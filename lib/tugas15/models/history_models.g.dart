// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModels _$HistoryModelsFromJson(Map<String, dynamic> json) =>
    HistoryModels(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryModelsToJson(HistoryModels instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

HistoryData _$HistoryDataFromJson(Map<String, dynamic> json) => HistoryData(
  id: (json['id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  checkIn: json['check_in'] == null
      ? null
      : DateTime.parse(json['check_in'] as String),
  checkInLocation: json['check_in_location'] as String?,
  checkInAddress: json['check_in_address'] as String?,
  checkOut: json['check_out'] == null
      ? null
      : DateTime.parse(json['check_out'] as String),
  checkOutLocation: json['check_out_location'] as String?,
  checkOutAddress: json['check_out_address'] as String?,
  status: json['status'] as String?,
  alasanIzin: json['alasan_izin'],
  checkInLat: json['check_in_lat'],
  checkInLng: json['check_in_lng'],
  checkOutLat: json['check_out_lat'],
  checkOutLng: json['check_out_lng'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$HistoryDataToJson(HistoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'check_in': instance.checkIn?.toIso8601String(),
      'check_in_location': instance.checkInLocation,
      'check_in_address': instance.checkInAddress,
      'check_out': instance.checkOut?.toIso8601String(),
      'check_out_location': instance.checkOutLocation,
      'check_out_address': instance.checkOutAddress,
      'status': instance.status,
      'alasan_izin': instance.alasanIzin,
      'check_in_lat': instance.checkInLat,
      'check_in_lng': instance.checkInLng,
      'check_out_lat': instance.checkOutLat,
      'check_out_lng': instance.checkOutLng,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

EditProfileRequest _$EditProfileRequestFromJson(Map<String, dynamic> json) =>
    EditProfileRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EditProfileRequestToJson(EditProfileRequest instance) =>
    <String, dynamic>{'name': instance.name, 'email': instance.email};
