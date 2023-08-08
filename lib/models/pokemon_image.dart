class PokemonImageModel {
  final int? id;
  final String imageUrl;

  PokemonImageModel({
    this.id = 0,
    required this.imageUrl,
  });

  factory PokemonImageModel.fromJson(Map<String, dynamic> json) {
    return PokemonImageModel(
      id: json['id'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
