import 'package:flutter/material.dart';
import 'package:ixia_build/day19/services/dio_client.dart';
import 'package:ixia_build/tugas14/models/pokedex.dart';
import 'package:ixia_build/tugas14/services/api.dart';
import 'package:ixia_build/tugas14/views/pokemon_detail_page.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ApiService apiService;
  late Future<List<PokemonDetail>> pokemonFuture;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    apiService = ApiService(dio);
    pokemonFuture = fetchPokemon();
  }

  Future<List<PokemonDetail>> fetchPokemon() async {
    // 1. Ambil list daftar Pokémon
    final pokedex = await apiService.getAllPokemon(30, 0);

    // 2. Ambil item results dari list
    final results = pokedex.results ?? [];

    // 3. Filter list agar tidak ada item dengan name null / kosong
    final validPokemons = results.where(
      (pokemon) => pokemon.name != null && pokemon.name!.isNotEmpty,
    );

    // 4. Ambil detail masing-masing Pokémon secara paralel
    final pokemonDetails = await Future.wait<PokemonDetail>(
      validPokemons.map(
        (pokemon) => apiService.getPokemonDetail(pokemon.name!),
      ),
    );

    return pokemonDetails;
  }

  Future<void> refreshData() async {
    setState(() {
      pokemonFuture = fetchPokemon();
    });
    await pokemonFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokémon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<PokemonDetail>>(
        future: pokemonFuture,
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 70,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Gagal mengambil data Pokémon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pokemonFuture = fetchPokemon();
                        });
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // SUCCESS
          final pokemonList = snapshot.data ?? [];

          if (pokemonList.isEmpty) {
            return const Center(child: Text('Data Pokémon tidak ditemukan.'));
          }

          return RefreshIndicator(
            color: Colors.red,
            onRefresh: refreshData,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PokemonDetailPage(pokemon: pokemon),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // IMAGE CONTAINER
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              pokemon.officialArtwork ?? '',
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          // TEXT INFORMATION
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${pokemon.id ?? (index + 1)}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  (pokemon.name ?? '').toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Official Artwork',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
