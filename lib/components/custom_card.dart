import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconData,
  });

  final String title;
  final String subtitle;
  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        surfaceTintColor: const Color(0xfffff5d2),
        color: const Color(0xfffff5d2),
        child: GestureDetector(
          onTap: onTap,
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              iconData,
              size: 24.0,
              color: const Color(0xff141946),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                color: Color(0xff141946),
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                color: Color(0xff141946),
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            trailing: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff141946),
            ),
          ),
        )
      ),
    );
  }
}
