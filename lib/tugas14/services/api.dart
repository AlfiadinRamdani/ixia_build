import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/pokedex.dart'; // Pastikan dalam ini ada class untuk response list

part 'api.g.dart';

@RestApi(baseUrl: 'https://pokeapi.co/api/v2')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 1. Mengambil daftar Pokémon (Gunakan model Pokedex / PokemonList)
  @GET('/pokemon')
  Future<Pokedex> getAllPokemon(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  // 2. Mengambil detail Pokémon berdasarkan nama/ID
  @GET('/pokemon/{name}')
  Future<PokemonDetail> getPokemonDetail(
    @Path('name') String name,
  );
}