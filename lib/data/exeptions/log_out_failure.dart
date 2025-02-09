class LogOutFailure implements Exception {
  final String message;

  const LogOutFailure([this.message = 'Errore in fase di LogOut!']);
}
