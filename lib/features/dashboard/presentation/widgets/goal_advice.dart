/// Conseil affiché sur le tableau de bord, dérivé de l'objectif choisi
/// pendant l'onboarding — spécification 01.6, `OBJ-06-6`.
///
/// « Générée à partir du profil d'onboarding — jamais générique », dit la
/// spécification. Ces textes sont donc écrits objectif par objectif.
///
/// Aucun produit ni service financier tiers n'y est nommé (FR54, UX-DR4).
String adviceForGoal(String? goalId) {
  return switch (goalId) {
    'budget' => 'Commence par noter tes dépenses pendant deux semaines. '
        'Sans ce point de départ, aucun budget ne tient.',
    'debts' => 'Cartographie d’abord toutes tes dettes, même les petites. '
        'On établira ensuite l’ordre de remboursement le moins coûteux.',
    'save' => 'Lance une simulation pour savoir combien mettre de côté '
        'chaque mois. Un objectif chiffré tient mieux qu’une intention.',
    'invest' => 'Avant d’investir, assure-toi d’avoir de quoi tenir trois '
        'mois de dépenses. C’est ce qui évite de revendre au mauvais moment.',
    'learn' => 'Chaque chiffre affiché ici est explicable. Touche l’icône '
        'd’aide dès qu’un terme te freine.',
    _ => 'Note ta première dépense pour commencer à y voir clair.',
  };
}
