import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googlesignin = GoogleSignIn();
  bool _issignIn;

  GoogleSigninProvider() {
    _issignIn = false;
  }

  bool get isSignin => _issignIn;

  set isSignin(bool isSignin) {
    _issignIn = isSignin;
    notifyListeners();
  }

  Future login() async {
    _issignIn = true;
    final user = await googlesignin.signIn();
    if (user == null) {
      _issignIn = false;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      _issignIn = false;
    }
  }

  void logout() async {
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
