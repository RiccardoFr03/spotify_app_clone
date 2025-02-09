class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = 'Errore generico!']);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email non valida!',
        );
      case 'network-request-failed':
        return const LogInWithEmailAndPasswordFailure(
          'Errore di connessione ad internet!',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'Utente disabilitato!',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email non trovata, crea un account!',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Password errata, prova di nuovo!',
        );
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          'Email o password errata!',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
