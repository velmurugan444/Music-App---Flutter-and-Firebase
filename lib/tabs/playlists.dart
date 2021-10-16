import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/screens/audioplay_screen.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('playlists')
            .where("email", isEqualTo: user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot myPost = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String songname = myPost['songname'];
                                    String songurl = myPost['songurl'];
                                    String author = myPost['author'];
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new AudioPlayScreen(
                                                    songname: songname,
                                                    songurl: songurl,
                                                    author: author)));
                                  },
                                  child: ListTile(
                                      leading: CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage:
                                              AssetImage('assets/music.jpeg')),
                                      title: Text(
                                        '${myPost['songname']}',
                                        style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Text('${myPost['author']}')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
