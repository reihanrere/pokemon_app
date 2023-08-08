import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/pokemon_cubit.dart';
import 'package:pokemon_app/repository/pokemon_repository.dart';
import 'package:pokemon_app/themes/theme.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PokemonCubit>().fetchPokemonList();
  }

  void _handleSearch(String keyword) {
    if (keyword.isNotEmpty) {
      context.read<PokemonCubit>().fetchPokemonSearch(keyword);
    } else {
      context.read<PokemonCubit>().fetchPokemonList();
    }
  }

  Widget header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 252,
            height: 88,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pokemon.png"),
              ),
            ),
          ),
          Container(
            width: 252,
            height: 88,
            padding: EdgeInsets.only(
              top: 31,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _handleSearch,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGreyColor,
                label: Center(
                  child: Text(
                    "Search Pokemon",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 18,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(context) {
    return Expanded(
      child: BlocConsumer<PokemonCubit, PokemonState>(
        listener: (context, state) {
          if (state is PokemonLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        builder: (context, state) {
          if (state is PokemonSuccess) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: state.pokemons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 19,
              ),
              itemBuilder: (contexts, index) {
                final pokemon = state.pokemons[index];
                final formattedId =
                    "#${(index + 1).toString().padLeft(3, '0')}";
                return GestureDetector(
                  onTap: () async {
                    try {
                      final pokemonDetail = await PokemonRepository()
                          .fetchPokemonDetail(pokemon.name.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(pokemonDetail),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 33),
                        height: 115,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              width: double.infinity,
                              height: 28,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kBlackColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x07000000),
                                    blurRadius: 2.21,
                                    offset: Offset(0, 2.77),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x0A000000),
                                    blurRadius: 5.32,
                                    offset: Offset(0, 6.65),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 10.02,
                                    offset: Offset(0, 12.52),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x0F000000),
                                    blurRadius: 17.87,
                                    offset: Offset(0, 22.34),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x12000000),
                                    blurRadius: 33.42,
                                    offset: Offset(0, 41.78),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 80,
                                    offset: Offset(0, 100),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedId,
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: extraBold,
                                    ),
                                  ),
                                  Text(
                                    pokemon.name.toString(),
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: extraBold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PokemonFailed) {
            return Center(
              child: Text(
                state.error,
                style: primaryTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: bold,
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 60,
          right: 24,
          left: 24,
          bottom: 27,
        ),
        child: Column(
          children: [
            header(),
            content(context),
          ],
        ),
      ),
    );
  }
}
