import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/providers/googlesignin_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    //audioCache = AudioCache(fixedPlayer: audioPlayer);
    // ignore: deprecated_member_use
    audioPlayer.durationHandler = (d) => {
          setState(() {
            _duration = d;
          })
        };
    // ignore: deprecated_member_use
    audioPlayer.positionHandler = (p) => {
          setState(() {
            _position = p;
          })
        };
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logged in",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Name : ' + user.displayName,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Email : ' + user.email,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text("Logout")),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                audioPlayer.pause();
              },
              child: Text("pause"),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                audioPlayer.stop();
              },
              child: Text("stop"),
            ),
            Slider(
              value: _position.inSeconds.toDouble(),
              onChanged: (double value) {
                print(value);
                setState(() {
                  Duration newDuration = Duration(seconds: value.toInt());
                  audioPlayer.seek(newDuration);
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.orange,
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            //audioCache.load('ayan.mp3');
            //audioCache.play('ayan.mp3');
            audioPlayer.play(
                "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3");
          }),
    );
  }
}
