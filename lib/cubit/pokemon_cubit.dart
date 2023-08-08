import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/models/pokemon_list_model.dart';
import 'package:pokemon_app/repository/pokemon_repository.dart';

import '../models/pokemon_detail_model.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  List<PokemonListModel> _allPokemon = [];
  PokemonCubit() : super(PokemonInitial());

  void fetchPokemonList() async {
    try {
      emit(PokemonLoading());
      _allPokemon = await PokemonRepository().getAllPokemon();

      emit(PokemonSuccess(_allPokemon));
    } catch (e) {
      emit(PokemonFailed(e.toString()));
    }
  }

  void fetchPokemonSearch(String keyword) async {
    try {
      emit(PokemonLoading());
      List<PokemonListModel> searchResults = _allPokemon
          .where((pokemon) => pokemon.name!.contains(keyword))
          .toList();
      emit(PokemonSuccess(searchResults));
    } catch (e) {
      emit(PokemonFailed(e.toString()));
    }
  }

  void fetchDetailPokemon(String name) async {
    try {
      emit(PokemonLoading());

      PokemonDetailModel pokemonDetail =
          await PokemonRepository().fetchPokemonDetail(name);

      emit(PokemonDetailSuccess(pokemonDetail));
    } catch (e) {}
  }
}
