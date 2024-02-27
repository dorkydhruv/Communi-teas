import 'package:community_app/state/auth/constants/constants.dart';
import 'package:community_app/state/auth/models/auth_result.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get userLoggedIn => userId != null;
  String get userDisplayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> logInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      return AuthResult.aborted;
    } else {
      final oAuthCredential = FacebookAuthProvider.credential(token);
      try {
        await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
        return AuthResult.success;
      } on FirebaseAuthException catch (e) {
        final email = e.email;
        final credential = e.credential;
        if (e.code == Constants.accountExistsWithDifferentCredential &&
            email != null &&
            credential != null) {
          final providers =
              await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
          if (providers.contains(Constants.googleCom)) {
            await loginWithGoogle();
            FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
          }
          return AuthResult.success;
        }
        return AuthResult.failure;
      }
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }
}
