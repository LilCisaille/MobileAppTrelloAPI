import 'package:flutter/material.dart';

class CustomButton extends TextButton {
  CustomButton({
    super.key,
    required String text,
    required IconData? iconName,
    required VoidCallback super.onPressed,
  }) : super(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(253, 218, 95, 1)),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 20)),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        )),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(iconName, size: 20, color: const Color.fromRGBO(20, 25, 70, 1),),
          const SizedBox(width: 8),
          Text(text.toLowerCase(),
              style: const TextStyle(
                fontFamily: 'LexendExa',
                color: Colors.black,
              )
          ),
        ],
      ));
}