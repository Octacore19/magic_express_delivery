import 'package:flutter/material.dart';

class TextUtil {
  const TextUtil._();

  static void setText(TextEditingController controller, String text) {
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}