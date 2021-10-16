import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteSongs extends StatefulWidget {
  @override
  _DeleteSongsState createState() => _DeleteSongsState();
}

class _DeleteSongsState extends State<DeleteSongs> {
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
                                  onTap: () {},
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
                                    subtitle: Text('${myPost['author']}'),
                                    trailing: IconButton(
                                      iconSize: 30,
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("playlists")
                                            // ignore: deprecated_member_use
                                            .document(myPost.id)
                                            .delete();
                                      },
                                    ),
                                  ),
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
