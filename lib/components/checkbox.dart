import 'package:flutter/material.dart';

class CustomCheckbox extends Checkbox {
  const CustomCheckbox({
    super.key,
    required bool super.value,
    required super.onChanged,
    super.autofocus = false,
  }) : super(
    activeColor: const Color(0xfffcda5e),
    focusColor: const Color(0xfffcda5e),
    hoverColor: const Color(0xfffcda5e),
    tristate: false,
    side: const BorderSide(
      color: Color(0xfffcda5e),
      width: 2.0,
      style: BorderStyle.solid,
    )
  );
}