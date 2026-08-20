import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Formats de dates francophones (Dates.monthYear, Dates.long…).
  await initializeDateFormatting('fr_FR');

  if (Env.isSupabaseConfigured) {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabaseAnonKey,
    );
  } else {
    debugPrint(
      '[Supabase] Configuration absente — les fonctions backend sont '
      'désactivées. Lance avec --dart-define-from-file=env.json une fois '
      'ton projet Supabase créé.',
    );
  }

  runApp(const ProviderScope(child: SiraApp()));
}
