import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/providers/googlesignin_provider.dart';
import 'package:musicapp/screens/playlist_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File sampleImage;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            // ignore: deprecated_member_use
            overflow: Overflow.visible,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL),
                  minRadius: 50,
                  maxRadius: 75,
                ),
              ),
              // ignore: deprecated_member_use
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // ignore: deprecated_member_use
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // ignore: deprecated_member_use
          child: FlatButton(
              onPressed: () {},
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.supervisor_account_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    user.displayName,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
              )),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // ignore: deprecated_member_use
            child: FlatButton(
                onPressed: () {},
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                  ],
                )),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // ignore: deprecated_member_use
          child: FlatButton(
              onPressed: () {},
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Playlist()));
                    },
                    child: Icon(
                      Icons.playlist_play_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "Playlists",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
              )),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // ignore: deprecated_member_use
          child: FlatButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                provider.logout();
              },
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.logout,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
              )),
        ),
      ],
    ));
  }
}
