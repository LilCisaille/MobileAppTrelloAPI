import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  static const IconData defaultIcon = Icons.format_list_bulleted_sharp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        surfaceTintColor: const Color(0xFFFFF5D2),
        color: const Color(0xFFFFF5D2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        borderOnForeground: false,
        child: ExpansionTile(
          backgroundColor: const Color(0xFFFFF5D2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          expandedAlignment: Alignment.centerLeft,
          clipBehavior: Clip.antiAlias,
          leading: const Icon(
            defaultIcon,
            size: 24.0,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'LexendExa',
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'LexendExa',
              color: Colors.black,
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: const EdgeInsets.all(16.0),
          childrenPadding: const EdgeInsets.all(16.0),
          children: children,
        ),
      ),
    );
  }
}
