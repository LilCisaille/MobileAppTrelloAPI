import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.cardTitle,
    required this.memberAvatar,
    required this.onTap,
  });

  final String cardTitle;
  final String memberAvatar;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffffe5a1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          onTap: () {
            onTap();
          },
          tileColor: const Color(0xffffe5a1),
          contentPadding: const EdgeInsets.all(16.0),
          style: ListTileStyle.list,
          title: Text(
            cardTitle,
            style: const TextStyle(
              fontFamily: 'LexendExa',
              color: Color(0xff141946),
            ),
          ),
          trailing: CircleAvatar(
            backgroundImage: NetworkImage(memberAvatar),
          )
        ));
  }
}
