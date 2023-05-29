import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'View All',
            style: TextStyle(color: Colors.blueAccent),
          )
        ],
      ),
    );
  }
}
