import 'package:flutter/services.dart';

import 'currency.dart';

/// Insère les séparateurs de milliers pendant la frappe.
///
/// Le curseur reste en fin de saisie : les montants s'écrivent de gauche à
/// droite, on ne revient pas au milieu d'un nombre.
class CurrencyInputFormatter extends TextInputFormatter {
  const CurrencyInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final value = Currency.parse(newValue.text);
    if (value == 0) return const TextEditingValue();

    final formatted = Currency.formatAmount(value);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
