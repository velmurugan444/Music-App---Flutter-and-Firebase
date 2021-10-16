import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicapp/providers/googlesignin_provider.dart';
import 'package:provider/provider.dart';

class GoogleSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use
      child: OutlineButton.icon(
        label: Text(
          "Sign In With Google",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        highlightedBorderColor: Colors.black,
        borderSide: BorderSide(color: Colors.black),
        textColor: Colors.black,
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
        ),
        onPressed: () {
          final provider =
              Provider.of<GoogleSigninProvider>(context, listen: false);
          provider.login();
        },
      ),
    );
  }
}
