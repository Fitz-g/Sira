/// Résultat d'un appel de service.
///
/// Aucun service ne propage d'exception brute : il retourne un [Success] ou un
/// [Failure]. La classe étant scellée, un `switch` sur un [Result] doit traiter
/// les deux cas — le compilateur refuse d'ignorer l'erreur par omission.
///
/// ```dart
/// switch (await service.add(...)) {
///   case Success(:final data) => afficher(data),
///   case Failure(:final message) => signaler(message),
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Le message destiné à l'utilisateur, ou `null` en cas de succès.
  String? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(:final message) => message,
      };

  bool get isSuccess => this is Success<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.message);

  /// Message en langage courant, prêt à être affiché.
  ///
  /// Jamais un message technique : la trace part vers Sentry, l'utilisateur
  /// reçoit une phrase qu'il comprend.
  final String message;
}
