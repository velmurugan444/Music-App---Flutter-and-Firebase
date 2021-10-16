import 'package:flutter/material.dart';
import 'package:musicapp/widgets/google_signup_button.dart';

class SignupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 175,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Welcome to music app",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Spacer(),
          GoogleSignupButton(),
          SizedBox(
            height: 12,
          ),
          Text(
            "Login to continue",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
