part of 'pokemon_cubit.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonSuccess extends PokemonState {
  final List<PokemonListModel> pokemons;
  PokemonSuccess(this.pokemons);

  @override
  // TODO: implement props
  List<Object> get props => [pokemons];
}

class PokemonDetailSuccess extends PokemonState {
  final PokemonDetailModel pokemonDetailModel;

  PokemonDetailSuccess(this.pokemonDetailModel);

  @override
  // TODO: implement props
  List<Object> get props => [pokemonDetailModel];
}

class PokemonFailed extends PokemonState {
  final String error;

  PokemonFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
