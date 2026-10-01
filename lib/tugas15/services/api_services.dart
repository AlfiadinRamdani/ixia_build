import 'package:dio/dio.dart';
import 'package:ixia_build/tugas15/models/check_in_models.dart';
import 'package:ixia_build/tugas15/models/check_out_models.dart';
import 'package:ixia_build/tugas15/models/login_models.dart';
import 'package:ixia_build/tugas15/models/profil_models.dart';
import 'package:ixia_build/tugas15/models/register_models.dart';

import 'package:ixia_build/tugas15/models/edit_profile_models.dart';
import 'package:ixia_build/tugas15/models/edit_profile_models.dart';
import 'package:ixia_build/tugas15/models/history_models.dart'
    hide EditProfileRequest;

import 'package:retrofit/retrofit.dart';

// Pastikan dalam ini ada class untuk response list

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/api/register')
  Future<RegisterModel> registeruser(@Body() RegisterModel registerData);
  @POST('/api/login')
  Future<Loginrespon> loginuser(@Body() Loginmodels loginData);
  @POST('/api/absen/check-in')
  Future<CheckIn> checkuser(@Body() CheckInModels checkInData);
  // Check-out endpoint
  @POST('/api/absen/check-out')
  Future<CheckOut> checkoutuser(@Body() CheckOutModels checkoutData);

  @GET('/api/profile')
  Future<ProfilModels> profiluser();

  // Edit profile endpoint
  @PUT('/api/edit-profile')
Future<ProfilModels> editProfile(
  @Body() EditProfileRequest editData,
);

  // History attendance endpoint
  @GET('/api/history-absen')
  Future<HistoryModels> historyAbsen();

  // Delete attendance endpoint
  @DELETE('/api/delete-absen')
  Future<dynamic> deleteAbsen(@Query('id') int id);
}
