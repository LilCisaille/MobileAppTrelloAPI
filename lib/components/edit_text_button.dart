import 'package:flutter/material.dart';

class CustomIconEdit extends IconButton {
  const CustomIconEdit({
    super.key,
    required VoidCallback super.onPressed,
  }) : super(
          icon: const Icon(Icons.draw_outlined),
          iconSize: 30,
          color: const Color(0xffeabf16),
        );
}

class TestButton extends StatelessWidget {
  const TestButton({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomIconEdit(
            onPressed: () {
              print('IconButton Pressed!');
            },
          ),
        ),
      ),
    );
  }
}
