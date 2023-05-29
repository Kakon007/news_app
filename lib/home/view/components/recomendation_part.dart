import 'package:flutter/material.dart';

class RecomendationPart extends StatelessWidget {
  const RecomendationPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Recomendation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'View All',
            style: TextStyle(color: Colors.blueAccent),
          )
        ],
      ),
    );
  }
}
