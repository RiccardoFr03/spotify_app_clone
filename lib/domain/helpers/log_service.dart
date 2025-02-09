import 'package:logger/logger.dart';

class LogService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void d(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void i(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void w(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
