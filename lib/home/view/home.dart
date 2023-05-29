import 'package:flutter/material.dart';

import 'components/carousel_silder.dart';
import 'components/news_cards.dart';
import 'components/title_widget.dart';

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
      children: [
        const TitleWidget(title: "Breaking News"),
        const SizedBox(
          height: 15,
        ),
        const CarouselSliders(),
        const SizedBox(
          height: 20,
        ),
        const TitleWidget(title: "Top News"),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, i) {
              return const NewsCards();
            },
          ),
        )
      ],
    ));
  }
}
