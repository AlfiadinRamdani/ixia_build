// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokedex _$PokedexFromJson(Map<String, dynamic> json) => Pokedex(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'],
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PokedexToJson(Pokedex instance) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

Result _$ResultFromJson(Map<String, dynamic> json) =>
    Result(name: json['name'] as String?, url: json['url'] as String?);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
};

PokemonDetail _$PokemonDetailFromJson(Map<String, dynamic> json) =>
    PokemonDetail(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      baseExperience: (json['base_experience'] as num?)?.toInt(),
      sprites: json['sprites'] == null
          ? null
          : Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonDetailToJson(PokemonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'base_experience': instance.baseExperience,
      'sprites': instance.sprites,
    };

Sprites _$SpritesFromJson(Map<String, dynamic> json) => Sprites(
  other: json['other'] == null
      ? null
      : OtherSprites.fromJson(json['other'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SpritesToJson(Sprites instance) => <String, dynamic>{
  'other': instance.other,
};

OtherSprites _$OtherSpritesFromJson(Map<String, dynamic> json) => OtherSprites(
  officialArtwork: json['official-artwork'] == null
      ? null
      : OfficialArtwork.fromJson(
          json['official-artwork'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OtherSpritesToJson(OtherSprites instance) =>
    <String, dynamic>{'official-artwork': instance.officialArtwork};

OfficialArtwork _$OfficialArtworkFromJson(Map<String, dynamic> json) =>
    OfficialArtwork(frontDefault: json['front_default'] as String?);

Map<String, dynamic> _$OfficialArtworkToJson(OfficialArtwork instance) =>
    <String, dynamic>{'front_default': instance.frontDefault};
