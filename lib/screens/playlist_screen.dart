import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/screens/delete_songs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Playlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    TextEditingController _emailcontroller = new TextEditingController();
    _emailcontroller.text = user.email;
    TextEditingController _songnameController = new TextEditingController();
    TextEditingController _songurlController = new TextEditingController();
    TextEditingController _authorController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(actions: [
        GestureDetector(
            onTap: () {
              Alert(
                  context: context,
                  title: "ADD SONGS",
                  content: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Enter Email',
                        ),
                      ),
                      TextField(
                        controller: _songnameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.multitrack_audio_sharp),
                          labelText: 'Enter Songname',
                        ),
                      ),
                      TextField(
                        controller: _songurlController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.audiotrack_sharp),
                          labelText: 'Enter songurl',
                        ),
                      ),
                      TextField(
                        controller: _authorController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.supervised_user_circle),
                          labelText: 'Enter author',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () async {
                        String email = _emailcontroller.text;
                        String songname = _songnameController.text;
                        String songurl = _songurlController.text;
                        String author = _authorController.text;
                        Map<String, dynamic> data = {
                          "email": email,
                          "songname": songname,
                          "songurl": songurl,
                          "author": author
                        };
                        if (email == "" ||
                            songname == "" ||
                            songurl == "" ||
                            author == "") {
                          return "please fill all fields";
                        } else {
                          await FirebaseFirestore.instance
                              .collection("playlists")
                              .add(data);
                          _songnameController.text = "";
                          _songurlController.text = "";
                          _authorController.text = "";
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "ADD SONG",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]).show();
            },
            child: Icon(Icons.add))
      ], title: Text("Playlist")),
      body: DeleteSongs(),
    );
  }
}
