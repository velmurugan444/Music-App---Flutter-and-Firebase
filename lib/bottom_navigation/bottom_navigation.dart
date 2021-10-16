import 'package:flutter/material.dart';
import 'package:musicapp/tabs/local_playlist.dart';

import 'package:musicapp/tabs/playlists.dart';
import 'package:musicapp/tabs/profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  final tabs = [
    Center(
      child: MyAudioList(),
    ),
    Center(
      child: PlaylistScreen(),
    ),
    Center(
      child: ProfileScreen(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MUSIC APP"),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack_sharp),
              // ignore: deprecated_member_use
              title: Text("Local"),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text("Home"),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              // ignore: deprecated_member_use
              title: Text("Account"),
              backgroundColor: Colors.red),
        ],
        onTap: (
          index,
        ) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
