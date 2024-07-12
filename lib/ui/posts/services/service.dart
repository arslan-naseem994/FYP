import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final sanitizedValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formattedValue = '';

    if (sanitizedValue.isNotEmpty) {
      formattedValue +=
          sanitizedValue.substring(0, sanitizedValue.length.clamp(0, 2));

      if (sanitizedValue.length >= 3) {
        formattedValue += '/' +
            sanitizedValue.substring(2, sanitizedValue.length.clamp(2, 4));
      }
      if (sanitizedValue.length >= 5) {
        formattedValue += '/' +
            sanitizedValue.substring(4, sanitizedValue.length.clamp(4, 8));
      }
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
