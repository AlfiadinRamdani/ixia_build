import 'package:dio/dio.dart';
import 'package:ixia_build/tugas15/models/check_in_models.dart';
import 'package:ixia_build/tugas15/models/check_out_models.dart';
import 'package:ixia_build/tugas15/models/login_models.dart';
import 'package:ixia_build/tugas15/models/profil_models.dart';
import 'package:ixia_build/tugas15/models/register_models.dart';

import 'package:retrofit/retrofit.dart';

// Pastikan dalam ini ada class untuk response list

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 1. Mengambil daftar Pokémon (Gunakan model Pokedex / PokemonList)
  @POST('/api/register')
  Future<RegisterModel> registeruser(@Body() RegisterModel registerData);
  @POST('/api/login')
  Future<Loginrespon> loginuser(@Body() Loginmodels loginData);
  @POST('/api/check-in')
  Future<CheckIn> checkuser(@Body() CheckInModels checkInData);
  @POST('/api/check-out')
  Future<CheckOut> Checkuser(@Body() CheckOutModels checkoutData);
  // ✅ PERBAIKAN:
  @GET('/api/profile')
  Future<ProfilModels> profiluser();
}
