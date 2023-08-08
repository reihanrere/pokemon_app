import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_detail_model.dart';

import '../themes/theme.dart';

class DetailPage extends StatelessWidget {
  final PokemonDetailModel pokemon;
  const DetailPage(this.pokemon, {super.key});

  Widget header() {
    return Container(
      padding: EdgeInsets.only(
        top: 60,
        right: 24,
        left: 24,
      ),
      width: double.infinity,
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
        ],
      ),
    );
  }

  Widget typeList(List<String> types) {
    return Container(
      height: 38, // Set a specific height for the ListView.builder
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 20,
              left: 20,
            ),
            height: 38,
            decoration: BoxDecoration(
              color: kOrangeColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: ListBoxShadow,
            ),
            child: Center(
              child: Text(
                types[index].toUpperCase(),
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSpriteCarouselItems() {
    List<Widget> items = [];

    if (pokemon.backDefaultImageUrl != null) {
      items.add(Container(
        width: double.infinity,
        height: 500, // Set the desired height for the images
        child: Image.network(pokemon.backDefaultImageUrl!),
      ));
    }

    if (pokemon.backShinyImageUrl != null) {
      items.add(Container(
        width: double.infinity,
        height: 500, // Set the desired height for the images
        child: Image.network(pokemon.backShinyImageUrl!),
      ));
    }

    if (pokemon.frontDefaultImageUrl != null) {
      items.add(Container(
        width: double.infinity,
        height: 500, // Set the desired height for the images
        child: Image.network(pokemon.frontDefaultImageUrl!),
      ));
    }

    if (pokemon.frontShinyImageUrl != null) {
      items.add(Container(
        width: double.infinity,
        height: 500, // Set the desired height for the images
        child: Image.network(pokemon.frontShinyImageUrl!),
      ));
    }

    return items;
  }

  Widget content(context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 118,
                  right: 24,
                  left: 24,
                ),
                child: Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 24,
                  left: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${pokemon.id.toString().padLeft(3, '0')}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: extraBold,
                      ),
                    ),
                    Text(
                      pokemon.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: extraBold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 290,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(pokemon.imageUrl),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 24,
              left: 24,
              bottom: 34,
            ),
            child: typeList(pokemon.types),
          ),
          Container(
            width: double.infinity,
            height: 254,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 41, right: 41, left: 41),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Height",
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            "${pokemon.height / 10} m",
                            style: TextStyle(
                              color: Color.fromARGB(180, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Weight",
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            "${pokemon.weight / 10} kg",
                            style: TextStyle(
                              color: Color.fromARGB(180, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Species",
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            pokemon.speciesName,
                            style: TextStyle(
                              color: Color.fromARGB(180, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Abilities",
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Column(
                            children: pokemon.abilities
                                .map((ability) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        ability,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              180, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BoxShadow> get ListBoxShadow {
    return [
      BoxShadow(
        color: Color(0x04000000),
        blurRadius: 1.59,
        offset: Offset(0, 1.02),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x06000000),
        blurRadius: 3.62,
        offset: Offset(0, 2.31),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 6.31,
        offset: Offset(0, 4.02),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x08000000),
        blurRadius: 10.02,
        offset: Offset(0, 6.39),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 15.46,
        offset: Offset(0, 9.85),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0B000000),
        blurRadius: 24.12,
        offset: Offset(0, 15.38),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 40.04,
        offset: Offset(0, 25.52),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x11000000),
        blurRadius: 80,
        offset: Offset(0, 51),
        spreadRadius: 0,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(pokemon.backDefaultImageUrl);
    return Scaffold(
      body: Column(
        children: [
          header(),
          content(context),
        ],
      ),
    );
  }
}
