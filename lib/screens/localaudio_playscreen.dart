import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class LocalAudioPlayScreen extends StatefulWidget {
  final String songurl;
  LocalAudioPlayScreen({
    this.songurl,
  });
  @override
  _LocalAudioPlayScreenState createState() => _LocalAudioPlayScreenState();
}

class _LocalAudioPlayScreenState extends State<LocalAudioPlayScreen> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[800], Colors.blue[400]]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Music Beats",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Local Audio",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  width: 280.0,
                  height: 280.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                          image: AssetImage("assets/music.jpeg"))),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Center(
                child: Text(
                  "Local Audio",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Slider(
                      value: _position.inSeconds.toDouble(),
                      onChanged: (double value) {
                        print(value);
                        setState(() {
                          Duration newDuration =
                              Duration(seconds: value.toInt());
                          audioPlayer.seek(newDuration);
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.greenAccent,
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 45.0,
                            color: Colors.blue,
                            onPressed: () {},
                            icon: Icon(Icons.skip_previous)),
                        IconButton(
                            iconSize: 62.0,
                            color: Colors.blue[800],
                            onPressed: () {
                              if (!playing) {
                                setState(() {
                                  playBtn = Icons.pause;
                                  playing = true;
                                  audioPlayer.play(widget.songurl);
                                });
                              } else {
                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  playing = false;
                                  audioPlayer.pause();
                                });
                              }
                            },
                            icon: Icon(playBtn)),
                        IconButton(
                            iconSize: 45.0,
                            color: Colors.blue,
                            onPressed: () {},
                            icon: Icon(Icons.skip_next)),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
