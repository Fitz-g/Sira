import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/utils/currency_input_formatter.dart';

/// Espace insécable, séparateur de milliers du français.
///
/// Insécable et non ordinaire : elle empêche « 125 » et « 000 » de se
/// retrouver sur deux lignes différentes.
const nbsp = '\u00A0';

/// Applique le formateur à une saisie, comme le ferait le champ.
String _format(String input) {
  const formatter = CurrencyInputFormatter();
  return formatter
      .formatEditUpdate(
        const TextEditingValue(),
        TextEditingValue(
          text: input,
          selection: TextSelection.collapsed(offset: input.length),
        ),
      )
      .text;
}

void main() {
  test('insère les séparateurs de milliers', () {
    expect(_format('125000'), '125${nbsp}000');
    expect(_format('1250000'), '1${nbsp}250${nbsp}000');
  });

  test('laisse les petits nombres intacts', () {
    expect(_format('500'), '500');
  });

  test('ignore ce qui n’est pas un chiffre', () {
    expect(_format('12a5b00'), '12${nbsp}500');
  });

  test('vide le champ quand la saisie ne vaut rien', () {
    expect(_format(''), '');
    expect(_format('0'), '');
    expect(_format('abc'), '');
  });

  test('place le curseur en fin de saisie', () {
    const formatter = CurrencyInputFormatter();
    final result = formatter.formatEditUpdate(
      const TextEditingValue(),
      const TextEditingValue(text: '125000'),
    );

    // Les montants s'écrivent de gauche à droite : on ne revient pas au
    // milieu d'un nombre.
    expect(result.selection.baseOffset, result.text.length);
  });
}
