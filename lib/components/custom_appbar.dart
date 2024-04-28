import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/user_info_service.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
      : super(
    backgroundColor: Colors.white,
    leading: const Image(image: AssetImage('assets/images/logo.png')),
    title: Consumer<TokenMember>(
      builder: (context, tokenMember, child) {
        return Container(
            alignment: Alignment.centerRight,
            child: Text(
              'welcome ${tokenMember.member?.fullName ?? 'no user'} !',
              textAlign: TextAlign.end,
              textWidthBasis: TextWidthBasis.longestLine,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                fontSize: 14,
                color: Colors.black,
              ),
            )
        );
      },
    ),
  );
}