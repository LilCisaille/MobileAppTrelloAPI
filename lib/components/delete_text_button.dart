import 'package:flutter/material.dart';

class CustomIconDelete extends IconButton {
  const CustomIconDelete({
    super.key,
    required VoidCallback super.onPressed,
  }) : super(
          icon: const Icon(Icons.delete_outline_rounded),
          iconSize: 30,
          color: const Color.fromARGB(255, 213, 48, 3),
        );
}

class TestButton extends StatelessWidget {
  const TestButton({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomIconDelete(
            onPressed: () {
              print('IconButton Pressed!');
            },
          ),
        ),
      ),
    );
  }
}
