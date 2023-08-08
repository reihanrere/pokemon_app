import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/pokemon_detail_model.dart';
import 'package:pokemon_app/models/pokemon_image.dart';
import 'package:pokemon_app/models/pokemon_list_model.dart';

class PokemonRepository {
  Future<List<PokemonListModel>> getAllPokemon() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=10'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      List<dynamic> pokemonList = decodedData['results'];
      List<PokemonListModel> pokemonModels = pokemonList
          .asMap()
          .entries
          .map((entry) => PokemonListModel.fromJson({
                'id': entry.key + 1,
                'name': entry.value['name'],
              }))
          .toList();
      return pokemonModels;
    } else {
      throw Exception('Failed to fetch Pokemon list');
    }
  }

  Future<PokemonDetailModel> fetchPokemonDetail(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName/'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return PokemonDetailModel.fromJson(decodedData);
    } else {
      throw Exception('Failed to load Pokemon detail');
    }
  }

  Future<PokemonImageModel> fetchPokemonImage(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName/'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final imageUrl =
          decodedData['sprites']['other']['official-artwork']['front_default'];
      return imageUrl;
    } else {
      throw Exception('Failed to load Pokemon image');
    }
  }
}
