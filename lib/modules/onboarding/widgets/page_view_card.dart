import 'package:flutter/material.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  final String title;
  final String subTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 312,
            width: 312,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
