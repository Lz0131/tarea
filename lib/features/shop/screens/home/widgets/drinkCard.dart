import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tareas/features/shop/screens/home/colors.dart';
import 'package:tareas/features/shop/screens/home/widgets/drink_screen.dart';

class DrinkCard extends StatelessWidget {
  final DrinkScreen drink;
  final double pageOffset;
  final int index;
  double animation = 0;
  double animate = 0;
  double columnAnimation = 0;
  double rotate = 0;

  DrinkCard(this.drink, this.pageOffset, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;
    double count = 0;
    double page = pageOffset;
    rotate = index - pageOffset;

    // Calcular la animación basada en el offset de la página
    while (page > 1) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate =
        60 * (count + animation); // Ajustar para reducir el desplazamiento
    columnAnimation =
        40 * (index - pageOffset); // Ajuste del desplazamiento de la columna

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAboveCard(cardWidth, cardHeight, size),
          buildCupImage(size),
          buildBlurImage(cardWidth, size),
          buildSmallImage(size),
          buildTopImage(cardWidth, cardHeight, size),
        ],
      ),
    );
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          Text(
            drink.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: drink.lightColor,
            ),
          ),
          Text(
            drink.conName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: drink.dartColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .10,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            drink.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .10,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: drink.dartColor.withOpacity(.60),
        ),
        padding: const EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(
              -columnAnimation, 0), // Reducción del desplazamiento horizontal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Coca-Cola',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                drink.description,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 5),
                  Image.asset('images/cup_L.png'),
                  const SizedBox(width: 5),
                  Image.asset('images/cup_M.png'),
                  const SizedBox(width: 5),
                  Image.asset('images/cup_s.png'),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: mAppGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        '\$',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '4.',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      Text(
                        '70',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCupImage(Size size) {
    return Positioned(
      bottom: 20,
      right: -size.width * .1 / 2 + 10,
      child: Transform.rotate(
        angle: math.pi / 14 * rotate,
        child: Image.asset(drink.cupImage, height: size.height * .35 - 15),
      ),
    );
  }

  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth / 2 - 70 + animate,
      bottom: size.height * .10,
      height: 80,
      child: Image.asset(drink.imageBlur),
    );
  }

  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -10 + animate,
      top: size.height * .3,
      height: 80,
      child: Image.asset(drink.imageSmall),
    );
  }

  Widget buildTopImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      left: cardWidth / 1.5 - animate,
      bottom: size.height * .15 + cardHeight - 25,
      height: 80,
      child: Image.asset(drink.imageTop),
    );
  }
}
