class FirestoreFailure implements Exception {
  final String message;

  const FirestoreFailure([this.message = 'Errore generico!']);

  factory FirestoreFailure.fromCode(String code) {
    switch (code) {
      case 'cancelled':
        return const FirestoreFailure(
          'Operazione annullata!',
        );
      case 'invalid-argument':
        return const FirestoreFailure(
          'Argomento non valido!',
        );
      case 'deadline-exceeded':
        return const FirestoreFailure(
          'La scadenza dell\'operazione è stata superata!',
        );
      case 'not-found':
        return const FirestoreFailure(
          'Documento non trovato!',
        );
      case 'already-exists':
        return const FirestoreFailure(
          'Il documento esiste già!',
        );
      case 'permission-denied':
        return const FirestoreFailure(
          'Permesso negato!',
        );
      case 'resource-exhausted':
        return const FirestoreFailure(
          'Risorse esaurite!',
        );
      case 'failed-precondition':
        return const FirestoreFailure(
          'Condizione preliminare fallita!',
        );
      case 'aborted':
        return const FirestoreFailure(
          'Operazione abortita!',
        );
      case 'out-of-range':
        return const FirestoreFailure(
          'Risorsa fuori dal range consentito!',
        );
      case 'unimplemented':
        return const FirestoreFailure(
          'Operazione non implementata!',
        );
      case 'internal':
        return const FirestoreFailure(
          'Errore interno!',
        );
      case 'unavailable':
        return const FirestoreFailure(
          'Servizio non disponibile!',
        );
      case 'data-loss':
        return const FirestoreFailure(
          'Perdita di dati!',
        );
      case 'unauthenticated':
        return const FirestoreFailure(
          'Utente non autenticato!',
        );
      default:
        return const FirestoreFailure();
    }
  }
}
