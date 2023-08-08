class PokemonDetailModel {
  final int? id;
  final int weight;
  final int height;
  final String speciesName;
  final String name;
  final List<String> abilities;
  final List<String> types;
  final String imageUrl;
  final String? backDefaultImageUrl;
  final String? backShinyImageUrl;
  final String? frontDefaultImageUrl;
  final String? frontShinyImageUrl;

  PokemonDetailModel({
    this.id = 0,
    required this.weight,
    required this.height,
    required this.speciesName,
    required this.name,
    required this.abilities,
    required this.types,
    required this.imageUrl,
    this.backDefaultImageUrl,
    this.backShinyImageUrl,
    this.frontDefaultImageUrl,
    this.frontShinyImageUrl,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'],
      weight: json['weight'],
      height: json['height'],
      speciesName: json['species']['name'],
      name: json['name'],
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      backDefaultImageUrl: json['sprites']['back_default'],
      backShinyImageUrl: json['sprites']['back_shiny'],
      frontDefaultImageUrl: json['sprites']['front_default'],
      frontShinyImageUrl: json['sprites']['front_shiny'],
    );
  }
}
