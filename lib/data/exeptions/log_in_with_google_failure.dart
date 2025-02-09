class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure([this.message = 'Errore generico!']);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account già esistente!.',
        );
      case 'network-request-failed':
        return const LogInWithGoogleFailure(
          'Errore di connessione ad internet!',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'Credenziali non valide!',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operazione non consentita!',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'Utente disabilitato!',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email non trovata!',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Password non corretta!',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'Codice di verifica non corretto!',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'Codice di verifica ID non valido!',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}
