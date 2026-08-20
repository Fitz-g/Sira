/// Tokens d'interaction Sira — Design System `tokens/interactions.md`.
abstract final class AppMotion {
  /// Durée du feedback tactile sur les éléments pressables.
  static const pressDuration = Duration(milliseconds: 150);

  /// Réduction d'échelle au press.
  static const pressScale = 0.98;

  /// Opacité au press.
  static const pressOpacity = 0.85;

  /// Opacité d'un élément désactivé.
  static const disabledOpacity = 0.4;

  /// Durée d'affichage d'un toast avant disparition automatique.
  static const toastDuration = Duration(milliseconds: 2000);

  /// Durée des animations d'entrée / sortie d'un toast.
  static const toastTransition = Duration(milliseconds: 200);

  /// Durée de bascule d'un interrupteur.
  static const toggleDuration = Duration(milliseconds: 200);

  /// Durée de mise à jour d'une valeur calculée en temps réel.
  static const valueUpdateDuration = Duration(milliseconds: 200);
}
