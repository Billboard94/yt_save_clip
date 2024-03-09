// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NoteTakingView extends StatefulWidget {
  const NoteTakingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoteTakingViewState();
  }
}

class NoteTakingViewState extends State<NoteTakingView> {
  late YoutubePlayerController noteControllerYT;
  final String videoURL =
      "https://www.youtube.com/watch?v=mIYlLYu2554"; //get videoURL from the search page
  final _noteController = TextEditingController();
  // bool isPressed = false;

  @override
  void initState() {
    super.initState();

    noteControllerYT = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        // startAt: 25,
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    // noteControllerYT.dispose();
    super.dispose();
  }

  Widget buildPopupDialog(BuildContext context) {
    TextEditingController clipStart = TextEditingController();
    // TextEditingController clipEnd = TextEditingController();
    // TextEditingController clipTitle = TextEditingController();

    return AlertDialog(
      title: const Text('Specify the Clip Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Specify Start Time",
                ),
                controller: clipStart,
              ),
              // TextField(
              //   decoration: const InputDecoration(
              //     hintText: "Specify End Time",
              //   ),
              //   controller: clipEnd,
              // ),
              // TextField(
              //   decoration: const InputDecoration(
              //     hintText: "Specify Title",
              //   ),
              //   controller: clipTitle,
              // ),
            ],
          ),
        ],
      ),
      //add 2 buttons "save" and "close" -> save parses the user data to the YoutubeVideoController
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // isPressed = true;
            noteControllerYT.seekTo(
              Duration(seconds: int.parse(clipStart.text)),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: <Widget>[
          YoutubePlayer(
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
              controller: noteControllerYT
              // = YoutubePlayerController(
              //   initialVideoId: YoutubePlayer.convertUrlToId(videoURL)!,
              //   flags: const YoutubePlayerFlags(
              //     autoPlay: false,
              //     mute: false,
              ),
          // ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 301,
            child: TextField(
              controller: _noteController,
              maxLines: null,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        backgroundColor: Colors.orange[800],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => buildPopupDialog(context),
          );
        },
      ),
    );
  }
}
