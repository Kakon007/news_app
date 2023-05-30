import 'package:flutter/material.dart';

import '../../home/view/components/news_cards.dart';

class TopNewsScreen extends StatefulWidget {
  const TopNewsScreen({super.key});

  @override
  State<TopNewsScreen> createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, i) {
          return const NewsCards();
        },
      ),
    );
  }
}
