import 'dart:async';

import 'package:flutter/widgets.dart';

class AuthRedirectHelper extends ChangeNotifier {
  AuthRedirectHelper(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((event) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}