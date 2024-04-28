import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String name;
  final String? errorText;
  final Function(String) onTextChanged;
  final String? helperText;

  const CustomTextField({
    super.key,
    required this.name,
    required this.onTextChanged,
    this.helperText,
    this.errorText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 24.0),
          child: Text(
            '${widget.name} :',
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'LexendExa',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          width: MediaQuery.of(context).size.width - 32.0,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'LexendExa',
            ),
            controller: _textController,
            onChanged: widget.onTextChanged,
            decoration: InputDecoration(
              hintText: widget.helperText,
              contentPadding: const EdgeInsets.all(16.0),
              errorText: widget.errorText,
              filled: true,
              fillColor: const Color(0xffffe4a1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color:  Color.fromRGBO(253, 218, 95, 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
