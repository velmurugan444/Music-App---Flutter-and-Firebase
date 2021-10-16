import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/bottom_navigation/bottom_navigation.dart';
import 'package:musicapp/providers/googlesignin_provider.dart';
import 'package:musicapp/widgets/signup_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => GoogleSigninProvider(),
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                if (provider.isSignin) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  return BottomNavigation();
                }
                return SignupWidget();
              })),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
}
