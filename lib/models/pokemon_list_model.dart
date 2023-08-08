class PokemonListModel {
  int? id;
  String? name;

  PokemonListModel({
    required this.id,
    required this.name,
  });

  PokemonListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
