class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = 'Errore generico!']);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email non valida!',
        );
      case 'network-request-failed':
        return const SignUpWithEmailAndPasswordFailure(
          'Errore di connessione ad internet!',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'Utente disabilitato!',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'Utente già esistente!',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operazione non permessa!',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Password troppo debole!',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
