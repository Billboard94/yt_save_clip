// ignore_for_file: file_names, avoid_print

import 'package:flutter/cupertino.dart';
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
  late YoutubePlayerController _noteControllerYT;
  final String _videoURL =
      "https://www.youtube.com/watch?v=FQ99-zPBfI0"; //get videoURL from the search page

  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _noteControllerYT = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_videoURL)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    TextEditingController clipStart = TextEditingController();
    TextEditingController clipEnd = TextEditingController();
    TextEditingController clipTitle = TextEditingController();

    return AlertDialog(
      title: const Text('Specify the Clip Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        //add 3 input prompts for the user: clip_start, clip_end, clip_title
        children: <Widget>[
          Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Specify Start Time",
                ),
                controller: clipStart,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Specify End Time",
                ),
                controller: clipEnd,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Specify Title",
                ),
                controller: clipTitle,
              ),
            ],
          ),
        ],
      ),
      //add 2 buttons "save" and "close" -> save parses the user data to the YoutubeVideoController
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print("$clipStart");
            print("$clipEnd");
            //Save the three clip-controllers to the database
            _noteControllerYT = YoutubePlayerController(
              initialVideoId: NoteTakingViewState()._videoURL,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                startAt: int.parse(clipStart.text),
                endAt: int.parse(clipEnd.text),
              ),
            );
            setState(() {});
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            print("Hello");
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        toolbarHeight: -5,
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: <Widget>[
          YoutubePlayer(
            controller: _noteControllerYT,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 276,
            child: TextField(
              controller: _noteController,
              maxLines: 9999999,
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
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
      ),
    );
  }
}

//integrate this into FloatingActionButtonGroup and include it within the save button

