import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'pokedex.g.dart';

Pokedex pokedexFromJson(String str) => Pokedex.fromJson(json.decode(str));

String pokedexToJson(Pokedex data) => json.encode(data.toJson());

@JsonSerializable()
class Pokedex {
  @JsonKey(name: "count")
  final int? count;

  @JsonKey(name: "next")
  final String? next;

  @JsonKey(name: "previous")
  final dynamic previous;

  @JsonKey(name: "results")
  final List<Result>? results;

  Pokedex({this.count, this.next, this.previous, this.results});

  factory Pokedex.fromJson(Map<String, dynamic> json) =>
      _$PokedexFromJson(json);

  Map<String, dynamic> toJson() => _$PokedexToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "url")
  final String? url;

  Result({this.name, this.url});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonDetail {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "height")
  final int? height;

  @JsonKey(name: "weight")
  final int? weight;

  @JsonKey(name: "base_experience")
  final int? baseExperience;

  @JsonKey(name: "sprites")
  final Sprites? sprites;

  // ELEMEN BARU: Types & Abilities dari PokeAPI
  @JsonKey(name: "types")
  final List<TypeEntry>? rawTypes;

  @JsonKey(name: "abilities")
  final List<AbilityEntry>? rawAbilities;

  PokemonDetail({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.baseExperience,
    this.sprites,
    this.rawTypes,
    this.rawAbilities,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailToJson(this);

  String? get officialArtwork => sprites?.other?.officialArtwork?.frontDefault;

  // HELPER GETTER UNTUK MEMUDAHKAN AKSES DI UI
  List<String>? get types => rawTypes
      ?.map((e) => e.type?.name ?? '')
      .where((element) => element.isNotEmpty)
      .toList();

  List<String>? get abilities => rawAbilities
      ?.map((e) => e.ability?.name ?? '')
      .where((element) => element.isNotEmpty)
      .toList();
}

// MODEL UNTUK PARSING TYPES POKEAPI
@JsonSerializable(explicitToJson: true)
class TypeEntry {
  @JsonKey(name: "slot")
  final int? slot;

  @JsonKey(name: "type")
  final NamedResource? type;

  TypeEntry({this.slot, this.type});

  factory TypeEntry.fromJson(Map<String, dynamic> json) => TypeEntry(
    slot: json['slot'] as int?,
    type: json['type'] == null
        ? null
        : NamedResource.fromJson(json['type'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'slot': slot,
    'type': type?.toJson(),
  };
}

// MODEL UNTUK PARSING ABILITIES POKEAPI
@JsonSerializable(explicitToJson: true)
class AbilityEntry {
  @JsonKey(name: "is_hidden")
  final bool? isHidden;

  @JsonKey(name: "slot")
  final int? slot;

  @JsonKey(name: "ability")
  final NamedResource? ability;

  AbilityEntry({this.isHidden, this.slot, this.ability});

  factory AbilityEntry.fromJson(Map<String, dynamic> json) => AbilityEntry(
    isHidden: json['is_hidden'] as bool?,
    slot: json['slot'] as int?,
    ability: json['ability'] == null
        ? null
        : NamedResource.fromJson(json['ability'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'is_hidden': isHidden,
    'slot': slot,
    'ability': ability?.toJson(),
  };
}

// MODEL REUSABLE UNTUK OBJEK {name, url} DARI TYPE / ABILITY
@JsonSerializable()
class NamedResource {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "url")
  final String? url;

  NamedResource({this.name, this.url});

  factory NamedResource.fromJson(Map<String, dynamic> json) =>
      NamedResource(name: json['name'] as String?, url: json['url'] as String?);

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name, 'url': url};
}

@JsonSerializable()
class Sprites {
  @JsonKey(name: "other")
  final OtherSprites? other;

  Sprites({this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}

@JsonSerializable()
class OtherSprites {
  @JsonKey(name: "official-artwork")
  final OfficialArtwork? officialArtwork;

  OtherSprites({this.officialArtwork});

  factory OtherSprites.fromJson(Map<String, dynamic> json) =>
      _$OtherSpritesFromJson(json);

  Map<String, dynamic> toJson() => _$OtherSpritesToJson(this);
}

@JsonSerializable()
class OfficialArtwork {
  @JsonKey(name: "front_default")
  final String? frontDefault;

  OfficialArtwork({this.frontDefault});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);
}
