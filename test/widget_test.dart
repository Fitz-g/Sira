import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/app.dart';

void main() {
  testWidgets("L'écran d'accueil affiche son message et ses deux actions",
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SiraApp()));
    await tester.pumpAndSettle();

    expect(find.text('Ton argent, maîtrisé.'), findsOneWidget);
    expect(find.text("C'est parti  →"), findsOneWidget);
    expect(find.text("J'ai déjà un compte"), findsOneWidget);
  });
}
