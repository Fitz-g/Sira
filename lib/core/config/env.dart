/// Configuration d'environnement.
///
/// Les valeurs sont injectées au lancement :
/// ```bash
/// flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
/// ```
/// ou, plus simplement, via un fichier :
/// ```bash
/// flutter run --dart-define-from-file=env.json
/// ```
abstract final class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Tant que la configuration est absente, l'app démarre en mode hors ligne :
  /// l'interface reste consultable, les appels backend sont désactivés.
  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
