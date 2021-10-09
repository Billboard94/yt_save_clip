// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:notaria/model/opacity_button.dart';
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
        initialVideoId: _videoURL,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
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
      // bottomNavigationBar: markdownEditor(),
      body: ListView(
        children: <Widget>[
          YoutubePlayer(
            controller: _noteControllerYT,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TextField(
                controller: _noteController,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),)
    );
  }
}
