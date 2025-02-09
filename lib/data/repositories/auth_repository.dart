import 'package:firebase_auth/firebase_auth.dart' as firebase_auth_package;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:spotify_clone/data/clients/cache_client.dart';
import 'package:spotify_clone/data/exeptions/firestore_failure.dart';
import 'package:spotify_clone/data/exeptions/log_in_with_email_and_password_failure.dart';
import 'package:spotify_clone/data/exeptions/log_out_failure.dart';
import 'package:spotify_clone/data/exeptions/sign_up_with_email_and_password_failure.dart';
import 'package:spotify_clone/domain/helpers/log_service.dart';
import 'package:spotify_clone/domain/models/user_model.dart';
import '../exeptions/log_in_with_google_failure.dart';

class AuthRepository {
  final CacheClient cache;
  final firebase_auth_package.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn.standard();

  @visibleForTesting
  bool isWeb;

  AuthRepository({
    CacheClient? cacheClient,
    firebase_auth_package.FirebaseAuth? firebaseAuthInstance,
    this.isWeb = kIsWeb,
  })  : cache = cacheClient ?? CacheClient(),
        firebaseAuth = firebaseAuthInstance ?? firebase_auth_package.FirebaseAuth.instance;

  @visibleForTesting
  static const userCacheKey = '_user_key_cache_';

  Stream<User> get user {
    return firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      final user = firebaseUser == null ? User.empty : await firebaseUser.toUser();
      cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw _handleAuthException(e, SignUpWithEmailAndPasswordFailure());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw _handleAuthException(e, LogInWithEmailAndPasswordFailure());
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      firebase_auth_package.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth_package.GoogleAuthProvider();
        final userCredential = await firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          return;
        }
        final googleAuth = await googleUser.authentication;
        credential = firebase_auth_package.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      await firebaseAuth.signInWithCredential(credential);
    } on firebase_auth_package.FirebaseAuthException catch (e) {
      final failure = LogInWithGoogleFailure.fromCode(e.code);
      LogService.e('FirebaseAuthException: ${failure.message}', error: e);
      throw failure;
    } catch (e, stacktrace) {
      const failure = LogInWithGoogleFailure();
      LogService.e('Unexpected error during sign up with google', error: e, stackTrace: stacktrace);
      throw failure;
    }
  }

  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = firebase_auth_package.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      await firebase_auth_package.FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } on firebase_auth_package.FirebaseAuthException catch (e) {
      final failure = SignUpWithEmailAndPasswordFailure.fromCode(e.code);
      LogService.e('FirebaseAuthException: ${failure.message}', error: e);
      throw failure;
    } catch (e, stacktrace) {
      const failure = SignUpWithEmailAndPasswordFailure();
      LogService.e('Unexpected error during sign up with apple', error: e, stackTrace: stacktrace);
      throw failure;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
      cache.write(key: userCacheKey, value: User.empty);
    } catch (e) {
      throw _handleAuthException(e, LogOutFailure());
    }
  }

  String getUserId() {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirestoreFailure.fromCode('unauthenticated');
    }
    return user.uid;
  }

  Exception _handleAuthException(Object e, Exception defaultFailure) {
    if (e is firebase_auth_package.FirebaseAuthException) {
      final failure = defaultFailure is SignUpWithEmailAndPasswordFailure
          ? SignUpWithEmailAndPasswordFailure.fromCode(e.code)
          : defaultFailure is LogInWithEmailAndPasswordFailure
              ? LogInWithEmailAndPasswordFailure.fromCode(e.code)
              : defaultFailure;

      LogService.e('FirebaseAuthException: ${failure.toString()}', error: e);
      return failure;
    } else {
      LogService.e('Unexpected error', error: e);
      return defaultFailure;
    }
  }
}

extension on firebase_auth_package.User {
  Future<User> toUser() async {
    return User(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      refreshToken: refreshToken,
    );
  }
}
