import 'package:flutter/widgets.dart';

/// Les icônes Lucide effectivement employées par Sira.
///
/// Le paquet `lucide_icons_flutter` expose ses icônes dans une seule classe de
/// 125 000 lignes, soit 12,9 Mo de source. L'importer fait déborder la pile du
/// compilateur web en mode debug, et alourdit la compilation partout ailleurs.
///
/// On ne conserve donc du paquet que sa police, et on déclare ici les seuls
/// points de code dont on se sert. Pour ajouter une icône : relever son code
/// dans `lucide_icons.dart` et l'inscrire ci-dessous.
abstract final class AppIcons {
  static const _f = 'Lucide';
  static const _p = 'lucide_icons_flutter';

  // --- Navigation et actions ---
  static const chevronLeft = IconData(57454, fontFamily: _f, fontPackage: _p);
  static const chevronRight = IconData(57455, fontFamily: _f, fontPackage: _p);
  static const close = IconData(57778, fontFamily: _f, fontPackage: _p);
  static const plus = IconData(57661, fontFamily: _f, fontPackage: _p);
  static const eye = IconData(57530, fontFamily: _f, fontPackage: _p);
  static const eyeOff = IconData(57531, fontFamily: _f, fontPackage: _p);

  // --- Retours d'état ---
  static const circleCheck = IconData(57894, fontFamily: _f, fontPackage: _p);
  static const circleX = IconData(57476, fontFamily: _f, fontPackage: _p);
  static const info = IconData(57593, fontFamily: _f, fontPackage: _p);
  static const lightbulb = IconData(57794, fontFamily: _f, fontPackage: _p);
  static const gauge = IconData(57791, fontFamily: _f, fontPackage: _p);
  static const partyPopper = IconData(58179, fontFamily: _f, fontPackage: _p);

  // --- Domaine financier ---
  static const trendingUp = IconData(57745, fontFamily: _f, fontPackage: _p);
  static const target = IconData(57728, fontFamily: _f, fontPackage: _p);
  static const piggyBank = IconData(57658, fontFamily: _f, fontPackage: _p);
  static const creditCard = IconData(57514, fontFamily: _f, fontPackage: _p);
  static const chartColumn = IconData(58019, fontFamily: _f, fontPackage: _p);
  static const house = IconData(57589, fontFamily: _f, fontPackage: _p);

  // --- Catégories de dépenses ---
  static const utensils = IconData(58102, fontFamily: _f, fontPackage: _p);
  static const bus = IconData(57812, fontFamily: _f, fontPackage: _p);
  static const pill = IconData(58301, fontFamily: _f, fontPackage: _p);
  static const plane = IconData(57822, fontFamily: _f, fontPackage: _p);
  static const shoppingCart = IconData(57692, fontFamily: _f, fontPackage: _p);
  static const users = IconData(57764, fontFamily: _f, fontPackage: _p);
  static const package = IconData(57641, fontFamily: _f, fontPackage: _p);
}
