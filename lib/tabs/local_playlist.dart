import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:musicapp/screens/localaudio_playscreen.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class MyAudioList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAudioList(); //create state
  }
}

class _MyAudioList extends State<MyAudioList> {
  var files;

  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
      excludedPaths: ["/storage/emulated/0/Android"],
      extensions: ["mp3"],
      //optional, to filter files, list only mp3 files
    );
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: files == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                //if file/folder list is grabbed, then show here
                itemCount: files?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                child: ListTile(
                                  title: Text(
                                    files[index].path.split('/').last,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                          AssetImage('assets/music.jpeg')),
                                ),
                                onTap: () {
                                  String songurl = files[index].path;
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new LocalAudioPlayScreen(
                                                songurl: songurl,
                                              )));
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ));
  }
}
