import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child : Stack(
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
              fontFamily: 'BungeeShade',
              fontSize: 22,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = const Color(0xfffcda5e),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.left,
            softWrap: true,
            style: const TextStyle(
              fontFamily: 'BungeeShade',
              fontSize: 22,
              color: Color.fromRGBO(20, 25, 70, 1),
            ),
          ),
        ],),
    );
  }
}