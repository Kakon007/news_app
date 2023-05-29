import 'package:flutter/material.dart';

import 'components/carousel_silder.dart';
import 'components/recomendation_part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        CarouselSliders(),
        SizedBox(
          height: 20,
        ),
        RecomendationPart()
      ],
    ));
  }
}
